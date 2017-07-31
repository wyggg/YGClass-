//
//  UIImage+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/16.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import "UIImage+YGTool.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (YGTool)


///从本地加载图片
+ (UIImage *)imageWithFilePath:(NSString *)filePath{
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:filePath ofType:nil]];
}

///根据data创建动图对象
+ (UIImage *)GIFImageWithData:(NSData *)data{
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    size_t imageCount = CGImageSourceGetCount(imageSource);
    if (imageCount <= 1) {
        return [UIImage imageWithData:data];
    }
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval duration = 0.0f;
    for (size_t i = 0; i < imageCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(imageSource, i, NULL);
        if (!imageRef) {
            continue;
        }
        duration += [self frameDurationAtIndex:i source:imageSource];
        [images addObject:[UIImage imageWithCGImage:imageRef scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
        CGImageRelease(imageRef);
    }
    if (!duration) {
        duration = (1.0f / 10.0f) * imageCount;
    }
    CFRelease(imageSource);
    
    return [UIImage animatedImageWithImages:images duration:duration];
}

+ (float)frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    
    CFRelease(cfFrameProperties);
    return frameDuration;
}

///根据Color创建Image
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGSize size = CGSizeMake(1.0f, 1.0f);
    return [UIImage imageWithColor:color imageSize:size];
}

///根据Color创建Image imageSize:图片的大小
+ (UIImage *)imageWithColor:(UIColor *)color imageSize:(CGSize)size{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//指定缩减的大小
- (UIImage *)scaleToSize:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}

//压缩图片质量
- (UIImage*)compressToQuality:(float)quality{
    NSData *data = UIImageJPEGRepresentation(self, quality);
    UIImage *image = [UIImage imageWithData:data];
    return image;
}

//保存图片到相册 action:回调方法
- (void)saveImageToPhotos:(id)target action:(SEL)action{
    UIImageWriteToSavedPhotosAlbum(self, target, action, nil);
}

//把图片渲染成黑白色
- (UIImage *)grayImage{
    int bitmapInfo = kCGImageAlphaNone;
    int width = self.size.width;
    int height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate (nil,width,height,8,0,colorSpace,bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    
    if (context == NULL){
        CGContextRelease(context);
        return nil;
    }
    
    CGContextDrawImage(context,CGRectMake(0, 0, width, height), self.CGImage);
    CGImageRef imgRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:imgRef];
    CGContextRelease(context);
    CGImageRelease(imgRef);
    return grayImage;
}

///模糊处理 高性能
- (UIImage *)imageFuzzy:(CGFloat)fuzzy{
    
    if (!fuzzy){return self;}
    if (fuzzy<0){fuzzy=0;}
    if (fuzzy>2.5){fuzzy=2.5;}
    
    int boxSize = (int)(fuzzy * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    //将image格式进行处理 防止出现异常 如 屏幕截图
//    CGImageRef img = self.CGImage;
    CGImageRef img = [UIImage imageWithData:UIImageJPEGRepresentation(self, 1)].CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"缓冲失败");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"错误 %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,outBuffer.width,outBuffer.height,8,outBuffer.rowBytes,colorSpace,kCGImageAlphaNoneSkipLast);
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    CGContextRelease(ctx);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}

- (void)imageFuzzy:(CGFloat)fuzzy block:(void(^)(UIImage *fuzzyImage))block{
    
    __block UIImage *fuzzyImage = nil;
    __weak typeof(self) aSelf = self;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        fuzzyImage = [aSelf imageFuzzy:fuzzy];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(fuzzyImage);
            }
        });
    });
}

@end
