//
//  NSTimer+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/13.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import "NSTimer+YGTool.h"

@implementation NSTimer (YGTool)

+ (void)execHelperBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)yg_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block{
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(execHelperBlock:) userInfo:[block copy] repeats:repeats];
}

+ (NSTimer *)yg_timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block{
    return [NSTimer timerWithTimeInterval:seconds target:self selector:@selector(execHelperBlock:) userInfo:[block copy] repeats:repeats];
}

@end
