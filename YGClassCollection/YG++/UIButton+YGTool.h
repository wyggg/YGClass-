//
//  UIButton+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/16.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ActionBlock)(UIButton *sender); //按钮点击事件

@interface UIButton (YGTool)

///设置纯色背景图片
- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;

///添加点击事件 Block回调
- (void)addTargetInBlockEvents:(UIControlEvents)events block:(ActionBlock)block;

///扩大按钮点击范围
- (void)setEnlargeEdgeWithTop:(CGFloat)top
                        right:(CGFloat)right
                       bottom:(CGFloat)bottom
                         left:(CGFloat)left;

@end
