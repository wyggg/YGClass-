//
//  WKWebView+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 17/3/9.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import "WKWebView+YGTool.h"

@implementation WKWebView (YGTool)

- (id)initWithScalesPageToFitFrame:(CGRect)frame{
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    return [self initWithFrame:frame configuration:wkWebConfig];
}

//获取网页图片
- (void)getAllImageUrlByJs:(void(^)(NSArray *urls))completionHandler
{
    
    ///获取网页全部图片地址
    NSString *jsCode_getImageURL = @"\
    function jsCode_getImageURL(){\
    var imgs = document.getElementsByTagName(\"img\");\
    var imgURLs=new Array(imgs.length);\
    for(var i = 0;i<imgs.length;i++){\
    imgURLs[i] = imgs[i].src;\
    }\
    return imgURLs;\
    };";
    [self evaluateJavaScript:jsCode_getImageURL completionHandler:nil];
    [self evaluateJavaScript:@"jsCode_getImageURL()" completionHandler:^(id Result, NSError * error) {
        completionHandler(Result);
    }];
}

///给网页图片跳转事件
- (void)addImageTargetEventsByJsWithKey:(NSString *)key{
    
    NSString *formtStr = [NSString stringWithFormat:@"\"%@/\"+n",key];
    
    NSString *jsCode = [NSString stringWithFormat:@"\
                        var imgArr=document.getElementsByTagName (\"img\");\
                        for(var i=0;i<imgArr.length;i++){\
                        imgArr[i].onclick=function(n){\
                        return function(){\
                        window.location.href=%@;\
                        };\
                        }(i)\
                        }"
                        ,formtStr];;
    
    
    [self evaluateJavaScript:jsCode completionHandler:^(id object, NSError * _Nullable error) {
        NSLog(@"%@",error);
    }];
}

///获取点击事件index 和点击事件配合使用
+ (NSInteger)getImageTargetIndex:(NSString *)imageTargetStr{
    NSArray *array = [imageTargetStr componentsSeparatedByString:@"/"];
    if (array.count>1) {
        return [[array lastObject] integerValue];
    }
    return 0;
}



@end
