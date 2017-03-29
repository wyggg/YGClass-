//
//  UIImage+YG_SDGIF.m
//  YGClassCollection
//
//  Created by iOS wugang on 17/3/29.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import "UIImage+YG_SDGIF.h"
#import "UIImage+YGTool.h"
#import "UIImage+GIF.h"
#import <objc/runtime.h>

@implementation UIImage (YG_SDGIF)

+ (void)yg_cacheDownloadImage:(NSURL *)imageUrl
                      options:(SDWebImageDownloaderOptions)options
                     progress:(SDWebImageDownloaderProgressBlock)progressBlock
                    completed:(SDWebImageDownloaderCompletedBlock)completedBlock{
    
    
    NSString *key = [[SDWebImageManager sharedManager] cacheKeyForURL:imageUrl];
    
    //查询是否有缓存
    UIImage *gifImage = [[SDImageCache sharedImageCache] imageFromCacheForKey:key];
    
    if (gifImage) {
        
        NSLog(@"图片已使用缓存加载");
        if (completedBlock) {
            completedBlock(gifImage,nil,nil,YES);
        }
        return ;
    }
    
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:imageUrl options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
        if (progressBlock) {
            //下载中回调
            progressBlock(receivedSize,expectedSize,targetURL);
        }
        
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        
        if (error) {
            NSLog(@"图片下载失败");
            if (completedBlock) {
                completedBlock(image,data,error,finished);
            }
            return ;
        }
        
        NSLog(@"图片下载成功");
        //图片转换GIF
        UIImage *toImage = [image isGIF] ? [UIImage sd_animatedGIFWithData:data] : image;
        
        //图片加入SD缓存
        [[SDImageCache sharedImageCache] storeImageDataToDisk:data forKey:key];
        
        if (completedBlock) {
            completedBlock(toImage,data,error,finished);
        }
        
    }];
    
}

//交换实现
+ (void)load{
    [super load];
    //实现原理：替换SDWebImage "UIImage+GIF.h"文件 中转换动图的方法"sd_animatedGIFWithData" 原来的有缺陷 只能保留第一帧
    Method m1 = class_getClassMethod([UIImage class], @selector(sd_animatedGIFWithData:));
    Method m2 = class_getClassMethod([UIImage class], @selector(sd_animatedGIFWithDataNew:));
    method_exchangeImplementations(m1, m2);
}

///根据data创建动图对象
+ (UIImage *)sd_animatedGIFWithDataNew:(NSData *)data{
    return [UIImage GIFImageWithData:data];
}

@end
