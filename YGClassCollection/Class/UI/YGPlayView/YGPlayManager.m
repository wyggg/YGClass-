//
//  YGPlayManager.m
//  Operator
//
//  Created by yg on 2018/1/8.
//  Copyright © 2018年 北京内圈科技有限公司. All rights reserved.
//

#import "YGPlayManager.h"



@interface YGPlayManager ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, weak) id timeObserve;
@property (nonatomic, assign) YGPlayState state;

@end

@implementation YGPlayManager

static YGPlayManager *_manager = nil;
+ (YGPlayManager *)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[super allocWithZone:NULL] init];
    });
    return _manager;
}

- (id)init{
    if (self = [super init]) {
        _state = YGPlayStateStop;
        _delegateArray = [NSPointerArray weakObjectsPointerArray];
        _player = [[AVPlayer alloc] init];
        [self addObserve];
    }
    return self;
}

- (void)addPlayDelegate:(id<YGMp3PlayDelegate>)delegate{
    [self.delegateArray addPointer:(__bridge void *)(delegate)];
}

- (void)removePlayDelegate:(id<YGMp3PlayDelegate>)delegate{
    for (int i=0; i<self.delegateArray.count; i++) {
        id object = [self.delegateArray pointerAtIndex:i];
        if (object == delegate) {
            [self.delegateArray removePointerAtIndex:i];
            NSLog(@"已移除 %@",object);
        }
    }
}


- (void)play{
    
    self.state = YGPlayStateOngoing;
    
    //开始播放
    for (id delegate in _delegateArray) {
        if (delegate && [delegate respondsToSelector:@selector(YGMp3PlayBeginPlay:)]) {
            [delegate YGMp3PlayBeginPlay:self];
        }
    }
    
    
    _currMediaDataSource = self.mediaDataSource;
    NSURL *url = [NSURL URLWithString:self.currMediaDataSource.mediaSource];
    AVPlayerItem *playerItem = [[AVPlayerItem alloc] initWithURL:url];
    [self.player replaceCurrentItemWithPlayerItem:playerItem];
    [self addItemObserve];
    [self.player play];
    [self continuePlay];
    
}

- (void)stop{
    _currMediaDataSource = nil;
    [self removeItemObserve];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    _totalTime = 0;
    _currentTime = 0;
    _totalBuffer = 0;
    
    self.state = YGPlayStateStop;
    
    //终止播放
    for (id delegate in _delegateArray) {
        
        if (delegate && [delegate respondsToSelector:@selector(YGMp3PlayStopPlay:)]) {
            [delegate YGMp3PlayStopPlay:self];
        }
    }
    
}

- (void)pause{
    [self.player setRate:0.0f];
    
    self.state = YGPlayStatePause;
    //暂停
    for (id delegate in _delegateArray) {
        
        if (delegate && [delegate respondsToSelector:@selector(YGMp3PlayPausePlay:)]) {
            [delegate YGMp3PlayPausePlay:self];
        }
    }
    
}

- (void)continuePlay{
    [self.player setRate:1.0f];
    self.state = YGPlayStateOngoing;
    //开始播放
    for (id delegate in _delegateArray) {
        if (delegate && [delegate respondsToSelector:@selector(YGMp3PlayBeginPlay:)]) {
            [delegate YGMp3PlayBeginPlay:self];
        }
    }
}

- (void)setState:(YGPlayState)state{
    _state = state;
}

- (YGPlayState)playState{
    return self.state;
}

- (void)addObserve{
    ///播放进度监听
    __weak typeof(self) weakSelf = self;
    self.timeObserve = [self.player addPeriodicTimeObserverForInterval:CMTimeMake(1.0, 1.0) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        float currentTime = CMTimeGetSeconds(time);
        float totalTime = CMTimeGetSeconds(weakSelf.player.currentItem.duration);
        
        if (isnan(totalTime)) {
            totalTime = 1;
        }
        
        _currentTime = currentTime;
        _totalTime = totalTime;
        //进度更新
        for (id delegate in weakSelf.delegateArray) {
            if (delegate && [delegate respondsToSelector:@selector(YGMp3Play:updateTime:sumTime:)]) {
                [delegate YGMp3Play:weakSelf updateTime:currentTime sumTime:totalTime];
            }
        }
    }];
}

- (void)addItemObserve{
    ///缓存状态监听
    [self.player.currentItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    [self.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //播放完毕监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:self.player.currentItem];
}

- (void)removeItemObserve{
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//缓存监听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    AVPlayerItem * songItem = object;
    //缓存进度监听
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray * array = songItem.loadedTimeRanges;
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue]; //本次缓冲的时间范围
        NSTimeInterval totalBuffer = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration); //缓冲总长度
        _totalBuffer = totalBuffer;
        
        for (id delegate in self.delegateArray) {
            if (delegate && [delegate respondsToSelector:@selector(YGMp3Play:updateTotalBuffer:sumTotalBuffer:)]) {
                [delegate YGMp3Play:self updateTotalBuffer:_totalBuffer sumTotalBuffer:_totalTime];
            }
        }
    }
    
    //播放状态监听
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerStatusUnknown:
                NSLog(@"KVO：未知状态，此时不能播放");
                break;
            case AVPlayerStatusReadyToPlay:
                NSLog(@"KVO：准备完毕，可以播放");
                break;
            case AVPlayerStatusFailed:
                NSLog(@"KVO：加载失败，网络或者服务器出现问题");
                break;
            default:
                break;
        }
        for (id delegate in self.delegateArray) {
            if (delegate && [delegate respondsToSelector:@selector(YGMp3Play:updateStatus:)]) {
                [delegate YGMp3Play:self updateStatus:self.player.status];
            }
        }
    }
    
}

//播放完成监听
- (void)playbackFinished:(NSNotification *)notice {
    NSLog(@"播放完毕");
    [self stop];
}



@end

