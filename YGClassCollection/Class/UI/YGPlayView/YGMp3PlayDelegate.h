//
//  YGMp3PlayDelegate.h
//  Operator
//
//  Created by yg on 2018/1/8.
//  Copyright © 2018年 北京内圈科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>

@class YGPlayManager;

@protocol YGMp3PlayDelegate <NSObject>

@optional

//播放进度更新
- (void)YGMp3Play:(YGPlayManager *)manager updateTime:(float)time sumTime:(float)sumTime;
//缓存进度
- (void)YGMp3Play:(YGPlayManager *)manager updateTotalBuffer:(float)totalBuffer sumTotalBuffer:(float)sumTotalBuffer;
//播放状态变更
- (void)YGMp3Play:(YGPlayManager *)manager updateStatus:(AVPlayerStatus)status;

//开始播放
- (void)YGMp3PlayBeginPlay:(YGPlayManager *)playerManager;
//暂停播放
- (void)YGMp3PlayPausePlay:(YGPlayManager *)playerManager;
//停止播放&播放完成
- (void)YGMp3PlayStopPlay:(YGPlayManager *)playerManager;


@end
