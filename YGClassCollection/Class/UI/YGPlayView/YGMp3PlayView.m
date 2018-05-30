//
//  YGMp3PlayView.m
//  Operator
//
//  Created by yg on 2018/1/8.
//  Copyright © 2018年 北京内圈科技有限公司. All rights reserved.
//

#import "YGMp3PlayView.h"
#import "YGPlayManager.h"
#import "UIView+YGTool.h"
#import <Masonry.h>

#define k_p_w (kScreenW-160)
#define kScreenW ([UIScreen mainScreen].bounds.size.width)
#define color_op_red [UIColor redColor]
#define kColor_TextGray_Shallow [UIColor blackColor]
#define FontOfSize(fontSize) [UIFont systemFontOfSize:fontSize]

@interface YGMp3PlayView ()<YGMp3PlayDelegate>

@property (nonatomic, strong) YGPlayManager *musicManager;

@end

@implementation YGMp3PlayView

- (id)init{
    if (self = [super init]) {
        self.musicManager = [YGPlayManager shareManager];
        [self loadUI];
        
    }
    return self;
}

- (void)loadUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    
    UIImageView *playImageView = [[UIImageView alloc] init];
    playImageView.backgroundColor = color_op_red;
    playImageView.userInteractionEnabled = YES;
    playImageView.image = [UIImage imageNamed:@"ICON_Broadcast"];
    [playImageView addTarget:self action:@selector(playImageViewEvents)];
    [self addSubview:playImageView];
    self.playImageView = playImageView;
    [playImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.width.height.offset(35);
        make.centerY.offset(0);
    }];
    
    UIView *bufferProgressView = [[UIView alloc] init];
    bufferProgressView.backgroundColor = kColor_TextGray_Shallow;
    [self addSubview:bufferProgressView];
    self.bufferProgressView = bufferProgressView;
    [bufferProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(60);
        make.height.offset(1);
        make.centerY.offset(0);
        make.width.offset(0);
    }];

    UIView *playProgressView = [[UIView alloc] init];
    playProgressView.backgroundColor = color_op_red;
    [self addSubview:playProgressView];
    self.playProgressView = playProgressView;
    [playProgressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(60);
        make.height.offset(1);
        make.centerY.offset(0);
        make.width.offset(0);
    }];
    
    UIImageView *scrollButton = [[UIImageView alloc] init];
    self.scrollButton = scrollButton;
    scrollButton.backgroundColor = [UIColor orangeColor];
    scrollButton.userInteractionEnabled = YES;
    [self addSubview:scrollButton];
    [scrollButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(10);
        make.centerY.offset(0);
        make.centerX.equalTo(playProgressView.mas_right);
    }];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    self.timeLabel = timeLabel;
    timeLabel.font = FontOfSize(10);
    [self addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-15);
        make.centerY.offset(0);
        make.right.offset(-15);
    }];
    
    timeLabel.attributedText = [self timeAttWithTime:@"00:45" sumTime:@"03:05"];
    
}

- (NSAttributedString *)timeAttWithTime:(NSString *)time sumTime:(NSString *)sumTime{
    NSString *string = [NSString stringWithFormat:@"%@/%@",time,sumTime];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:NSForegroundColorAttributeName value:color_op_red range:NSMakeRange(0, time.length)];
    return attStr;
}


//- (void)handlePan:(UIPanGestureRecognizer*)recognizer{
//    CGPoint translation = [recognizer translationInView:recognizer.view];
//
//    [recognizer.view mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.progressBackgroundView.mas_left).offset(translation.x);
//    }];
//
////    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);
////    [recognizer setTranslation:CGPointZero inView:self.progressBackgroundView];
//}

//更新播放进度
- (void)setPlayProgress:(float)playProgress{
    _playProgress = playProgress;
    if (_playProgress > 1) {
        _playProgress = 1;
    }
    NSLog(@"%f",k_p_w*_playProgress);
    [self.playProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(k_p_w*_playProgress);
    }];
    
}

//更新缓冲进度
- (void)setBufferProgress:(float)bufferProgress{
    _bufferProgress = bufferProgress;
    if (_bufferProgress > 1) {
        _bufferProgress = 1;
    }
    [self.bufferProgressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(k_p_w*_bufferProgress);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        [self layoutIfNeeded];
    }];
}

///播放、停止按钮点击
- (void)playImageViewEvents{
    
    
    YGPlayManager *manager = [YGPlayManager shareManager];
    
    if (manager.playState == YGPlayStateStop) {
        YGPlayModel *model = [[YGPlayModel alloc] init];
        model.playType = YGPlayType_Mp3URL;
        model.mediaSource = @"http://huawuyuan2.oss-cn-qingdao.aliyuncs.com/audiofile/2018011109581895460545795.mp3";
        manager.mediaDataSource = model;
        [manager play];
    }else if (manager.playState == YGPlayStatePause){
        [manager continuePlay];
    }else if (manager.playState == YGPlayStateOngoing){
        [manager pause];
    }
}

//开始播放
- (void)YGMp3PlayBeginPlay:(YGPlayManager *)playerManager{
    self.playImageView.image = [UIImage imageNamed:@"icon_zanting"];
}

//暂停播放
- (void)YGMp3PlayPausePlay:(YGPlayManager *)playerManager{
    self.playImageView.image = [UIImage imageNamed:@"ICON_Broadcast"];
}

//停止播放&播放完成
- (void)YGMp3PlayStopPlay:(YGPlayManager *)playerManager{
    self.playImageView.image = [UIImage imageNamed:@"ICON_Broadcast"];
}

//播放进度更新
- (void)YGMp3Play:(YGPlayManager *)manager updateTime:(float)time sumTime:(float)sumTime{
    self.playProgress = time/sumTime;
    
    NSDate *timeDate = [[NSDate alloc] initWithTimeIntervalSince1970:time];
    NSDate *sumTimeDate = [[NSDate alloc] initWithTimeIntervalSince1970:sumTime];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"mm:ss"];
    
    NSString *timeStr = [df stringFromDate:timeDate];
    NSString *sumTimeStr = [df stringFromDate:sumTimeDate];
    
    
    self.timeLabel.attributedText = [self timeAttWithTime:timeStr sumTime:sumTimeStr];
    NSLog(@"%f",self.playProgress);
}

//缓存进度
- (void)YGMp3Play:(YGPlayManager *)manager updateTotalBuffer:(float)totalBuffer sumTotalBuffer:(float)sumTotalBuffer{
    self.bufferProgress = totalBuffer/sumTotalBuffer;
}

//播放状态变更
- (void)YGMp3Play:(YGPlayManager *)manager updateStatus:(AVPlayerStatus)status{

}

- (void)close{
    [self.musicManager stop];
    [self setPlayProgress:0];
    [self setBufferProgress:1];
    self.playImageView.image = [UIImage imageNamed:@"ICON_Broadcast"];
    self.timeLabel.attributedText = [self timeAttWithTime:@"00:00" sumTime:@"00:00"];
    [self.musicManager removePlayDelegate:self];
}

- (void)enable{
    [self.musicManager addPlayDelegate:self];
}

@end
