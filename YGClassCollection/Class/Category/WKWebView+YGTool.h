//
//  WKWebView+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 17/3/9.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (YGTool)

///HTML文字自适应屏幕
- (id)initWithScalesPageToFitFrame:(CGRect)frame;

///获取网页图片 网页全部加载完毕后调用
- (void)getAllImageUrlByJs:(void(^)(NSArray *urls))completionHandler;
///获取点击事件index 和getAllImageUrlByJs配合使用 可实现图片点击放大
+ (NSInteger)getImageTargetIndex:(NSString *)imageTargetStr;

@end
