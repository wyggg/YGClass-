//
//  NSDate+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/14.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YGTool)

///计算某年某月有多少天
+ (NSInteger)dayInYears:(NSInteger)years month:(NSInteger)month;

///格式化时间为字符串
- (NSString *)dateByFormatString:(NSString *)formatStr;

///根据时间字符串生成时间
+ (NSDate *)dateByTimeString:(NSString *)timeStr formatStr:(NSString *)formatStr;

///将Unix时间戳格式化为时间字符串
+ (NSString *)dateStringByUnixTimeStamp:(NSTimeInterval)timeStamp formatStr:(NSString *)formatStr;

///将java时间戳格式化为时间字符串
+ (NSString *)dateStringByJavaTimeStamp:(NSTimeInterval)timeStamp formatStr:(NSString *)formatStr;

@end

#pragma mark - DateFormatStr
///yyyy-MM-dd
extern NSString *const YGDateFormatStr_1;
///yyyy年MM月dd日
extern NSString *const YGDateFormatStr_2;
///yyyy-MM-dd H:m:s
extern NSString *const YGDateFormatStr_3;
///yyyy年MM月dd日 H:m:s
extern NSString *const YGDateFormatStr_4;
///yyyy年MM月dd日 H点m分s秒
extern NSString *const YGDateFormatStr_5;
///yyyy-MM-dd 星期E
extern NSString *const YGDateFormatStr_6;
///yyyy年MM月dd日 星期E
extern NSString *const YGDateFormatStr_7;
///yyyy-MM-dd 星期E H:m:s
extern NSString *const YGDateFormatStr_8;
///yyyy年MM月dd日 星期E H点m分s秒
extern NSString *const YGDateFormatStr_9;
