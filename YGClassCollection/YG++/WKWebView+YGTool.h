//
//  WKWebView+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 17/3/9.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (YGTool)

//HTML文字自适应屏幕
- (id)initWithScalesPageToFitFrame:(CGRect)frame;

@end
