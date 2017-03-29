//
//  UIImage+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/16.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>

@interface UIImage (YGTool)

///图片去彩色
@property (nonatomic, assign, readonly) UIImage *grayImage;

///从本地加载图片
+ (UIImage *)imageWithFilePath:(NSString *)filePath;

///根据data创建GIF动图
+ (UIImage *)GIFImageWithData:(NSData *)data;

///根据Color创建一个1*1的Image
+ (UIImage *)imageWithColor:(UIColor *)color;

///根据Color创建Image imageSize:图片的大小
+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)size;

///压缩image的大小
- (UIImage *)scaleToSize:(CGSize)size;

//压缩图片质量
- (UIImage *)compressToQuality:(float)quality;

//保存图片到相册 action:回调方法
- (void)saveImageToPhotos:(id)target action:(SEL)action;

///模糊处理图片 fuzzy:模糊程度 0-1
- (UIImage *)imageFuzzy:(CGFloat)fuzzy;

///模糊处理图片（子线程运行） fuzzy:模糊程度 0-1
- (void)imageFuzzy:(CGFloat)fuzzy block:(void(^)(UIImage *fuzzyImage))block;

@end
