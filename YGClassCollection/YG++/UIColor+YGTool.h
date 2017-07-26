//
//  UIColor+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/5.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YGTool)

@property (nonatomic, readonly) NSDictionary *colorRGB;

#pragma mark - 颜色扩展

///随机色
+ (UIColor *)randomColor;

#pragma mark - 取图片主题色

///根据图片的主题色创建颜色
+ (UIColor *)colorWithImageTheme:(UIImage *)image;

///根据图片的主题色创建颜色（尺寸越小速度越快 但精度会变低）
+ (UIColor *)colorWithImageTheme:(UIImage *)image imageSize:(CGSize)size;

//从十六进制字符串获取颜色，
+ (UIColor *)colorWithHexString:(NSString *)color;

//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

//修改透明度
- (UIColor *)transparentColor:(CGFloat)transparent;
//获得颜色RGB的值
- (NSDictionary *)colorRGB;
//获得颜色RGB的值
- (id)colorRGBinCGFlot;

@end
