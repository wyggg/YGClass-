//
//  UIControl+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 17/1/10.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import "UIControl+YGTool.h"
#import <objc/runtime.h>

@implementation UIControl (YGTool)

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
- (NSTimeInterval)acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}
- (void)setAcceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

///注册AcceptEventInterval属性 否则不可用
+ (void)registeredAcceptEventInterval{
    
    static dispatch_once_t onceToken;
    
    //GCD函数 确保只执行一次
    dispatch_once(&onceToken, ^{
        
        //替换系统方法
        SEL    oldSel  = @selector(sendAction:to:forEvent:);
        SEL    newSel  = @selector(newSendAction:to:forEvent:);
        
        Method oldMet  = class_getInstanceMethod(self, oldSel);
        Method newMet  = class_getInstanceMethod(self, newSel);
        
        IMP    oldImp  = method_getImplementation(oldMet);
        IMP    newImp  = method_getImplementation(newMet);
        
        const char * oldType = method_getTypeEncoding(oldMet);
        const char * newType = method_getTypeEncoding(newMet);
        
        //动态添加Method
        BOOL isAdd = class_addMethod(self, newSel, newImp, newType);
        if (isAdd) {
            //替换
            class_replaceMethod(self, newSel, oldImp, oldType);
        }else{
            //交换
            method_exchangeImplementations(oldMet, newMet);
        }
        
    });
    
}

- (void)newSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
//    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
//        if (self.isExcuteEvent == 0) {
//            self.timeInterVal = self.timeInterVal = 0? defaultInterval:self.timeInterVal;
//        }
//        if (self.isExcuteEvent) return;
//        if (self.timeInterVal > 0) {
//            self.isExcuteEvent = YES;
//            [self performSelector:@selector(setIsExcuteEvent:) withObject:nil afterDelay:self.timeInterVal];
//        }
//    }
//    [self newSendAction:action to:target forEvent:event];
}

@end
