//
//  NSTimer+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/13.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (YGTool)

+ (void)execHelperBlock:(NSTimer *)timer;

/*因为ios10以上会和系统方法重名 所以方法名前边加上前缀*/

///添加定时任务Block执行
+ (NSTimer *)yg_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

///添加定时任务Block执行
+ (NSTimer *)yg_timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;

@end
