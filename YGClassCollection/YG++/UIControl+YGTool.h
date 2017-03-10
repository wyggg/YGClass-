//
//  UIControl+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 17/1/10.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (YGTool)

///设置按钮点击间隔时间（未完成）
@property (nonatomic, assign) NSTimeInterval acceptEventInterval;

///注册acceptEventInterval属性 否则将不可用
+ (void)registeredAcceptEventInterval;

@end
