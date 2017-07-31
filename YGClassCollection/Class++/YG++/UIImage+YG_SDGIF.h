//
//  UIImage+YG_SDGIF.h
//  YGClassCollection
//
//  Created by iOS wugang on 17/3/29.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDWebImageManager.h"

///让sdwebimage支持gif
@interface UIImage (YG_SDGIF)

///下载一张图片 自动缓存
+ (void)yg_cacheDownloadImage:(NSURL *)imageUrl
                          options:(SDWebImageDownloaderOptions)options
                         progress:(SDWebImageDownloaderProgressBlock)progressBlock
                        completed:(SDWebImageDownloaderCompletedBlock)completedBlock;

@end
