//
//  UIWebView+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/6.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import "UIWebView+YGTool.h"

@implementation UIWebView (YGTool)

///获得网页高度
- (CGFloat)htmlHeight{
    NSString *jsCode = @"document.body.scrollHeight";
    return [[self stringByEvaluatingJavaScriptFromString:jsCode] floatValue];
}

@end
