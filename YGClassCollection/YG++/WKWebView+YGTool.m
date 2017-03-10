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

@end
