//
//  YGPlayManager.h
//  Operator
//
//  Created by yg on 2018/1/8.
//  Copyright © 2018年 北京内圈科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGPlayModel.h"
#import "YGMp3PlayDelegate.h"
#import <AVKit/AVKit.h>


@interface YGPlayManager : NSObject

typedef NS_ENUM(NSInteger, YGPlayState){
    YGPlayStateStop = 0, //已停止
    YGPlayStateOngoing,  //正在播放
    YGPlayStatePause,    //暂停中
};

@property (nonatomic, strong) YGPlayModel * mediaDataSource;
@property (nonatomic, strong, readonly) YGPlayModel *currMediaDataSource;
@property (nonatomic, strong, readonly) NSPointerArray * delegateArray;

- (void)addPlayDelegate:(id<YGMp3PlayDelegate>)delegate;
- (void)removePlayDelegate:(id<YGMp3PlayDelegate>)delegate;

//当前媒体总时间
@property (nonatomic, assign, readonly) float totalTime;
//当前时间
@property (nonatomic, assign, readonly) float currentTime;
//音乐加载进度
@property (nonatomic, assign, readonly) float totalBuffer;
//当前状态
@property (nonatomic, assign, readonly) YGPlayState playState;

+ (YGPlayManager *)shareManager;
- (void)play;
- (void)stop;
- (void)pause;
- (void)continuePlay;

@end
