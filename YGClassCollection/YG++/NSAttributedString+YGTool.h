//
//  NSAttributedString+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/13.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSAttributedString (YGTool)

//计算富文本高度
- (CGFloat)heightWithContainWidth:(CGFloat)width;

//异步解析html字符串
+ (void)attributedStringWithHtmlString:(NSString *)string block:(void(^)(NSAttributedString *attString))block;

//优化富文本格式 适合手机屏幕上展示 规则1
+ (NSMutableAttributedString *)attributedStringFormPhoneString1:(NSAttributedString *)attStr;

@end
