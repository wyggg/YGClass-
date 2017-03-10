//
//  NSDate+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/14.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import "NSDate+YGTool.h"

#pragma mark - DateFormatStr

///yyyy-MM-dd
NSString *const YGDateFormatStr_1 = @"yyyy-MM-dd";
///yyyy年MM月dd日
NSString *const YGDateFormatStr_2 = @"yyyy年MM月dd日";
///yyyy-MM-dd H:m:s
NSString *const YGDateFormatStr_3 = @"yyyy-MM-dd H:m:s";
///yyyy年MM月dd日 H:m:s
NSString *const YGDateFormatStr_4 = @"yyyy年MM月dd日 H:m:s";
///yyyy年MM月dd日 H点m分s秒
NSString *const YGDateFormatStr_5 = @"yyyy年MM月dd日 H点m分s秒";
///yyyy-MM-dd 星期E
NSString *const YGDateFormatStr_6 = @"yyyy-MM-dd 星期E";
///yyyy年MM月dd日 星期E
NSString *const YGDateFormatStr_7 = @"yyyy年MM月dd日 星期E";
///yyyy-MM-dd 星期E H:m:s
NSString *const YGDateFormatStr_8 = @"yyyy-MM-dd 星期E H:m:s";
///yyyy年MM月dd日 星期E H点m分s秒
NSString *const YGDateFormatStr_9 = @"yyyy年MM月dd日 星期E H点m分s秒";

@implementation NSDate (YGTool)

///计算一个月多少天
+ (NSInteger)dayInYears:(NSInteger)years month:(NSInteger)month{
    //处理超出范围的情况
    if (month>12) {
        month = month%12;
        years+=1;
    }
    if (month < 1) {
        month = 12+month;
        years-=1;
    }
    if (month==1||month==3||month==5||month==7||month==8||month==10||month==12) {
        return 31;
    }
    else if (month==4||month==6||month==9||month==11){
        return 30;
    }
    else if (month==2){
        ///整百的年数
        if (years%100 == 0) {
            if (years%400 == 0) {
                return 29;
            }else{
                return 28;
            }
        }
        ///被4整除但是不被100整除
        if (years%4==0) {
            return 29;
        }else{
            return 28;
        }
    }
    return 0;
}

///根据时间字符串生成时间
+ (NSDate *)dateByTimeString:(NSString *)timeStr formatStr:(NSString *)formatStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = formatStr;
    NSDate *date = [dateFormatter dateFromString:timeStr];
    return date;
}

///将Unix时间戳格式化为时间字符串
+ (NSString *)dateStringByUnixTimeStamp:(NSTimeInterval)timeStamp formatStr:(NSString *)formatStr{
    return [[NSDate dateWithTimeIntervalSince1970:timeStamp] dateByFormatString:formatStr];
}

///将java时间戳格式化为时间字符串
+ (NSString *)dateStringByJavaTimeStamp:(NSTimeInterval)timeStamp formatStr:(NSString *)formatStr{
    return [[NSDate dateWithTimeIntervalSince1970:timeStamp/1000] dateByFormatString:formatStr];
}

///格式化时间为字符串
- (NSString *)dateByFormatString:(NSString *)formatStr{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatStr];
    return [dateFormatter stringFromDate:self];
}

@end
