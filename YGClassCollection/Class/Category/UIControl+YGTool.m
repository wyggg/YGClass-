//
//  UIControl+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 17/1/10.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import "UIControl+YGTool.h"
#import <objc/runtime.h>

@interface UIControl()
/**bool 类型 YES 不允许点击   NO 允许点击   设置是否执行点UI方法*/
@property (nonatomic, assign) BOOL isIgnoreEvent;

@end

@implementation UIControl (YGTool)

#pragma mark - 防止按钮重复点击

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
- (NSTimeInterval)acceptEventInterval
{
    return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setAcceptEventInterval:(NSTimeInterval)uxy_acceptEventInterval
{
    objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(uxy_acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent{
    // 注意BOOL类型 需要用OBJC_ASSOCIATION_RETAIN_NONATOMIC 不要用错，否则set方法会赋值出错
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

///注册AcceptEventInterval属性 否则不可用
+ (void)load{
    
    //确保只执行一次
    static dispatch_once_t onceToken;
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

//替换的方法
- (void)newSendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event
{
//    NSLog(@"按钮冷却中...");
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        
        self.acceptEventInterval = self.acceptEventInterval ==0  ?0.001:self.acceptEventInterval;
        if (self.isIgnoreEvent){
            return;
        }else if (self.acceptEventInterval > 0){
            [self performSelector:@selector(resetState) withObject:nil afterDelay:self.acceptEventInterval];
        }
    }
    
    self.isIgnoreEvent = YES;
    
    //这里实际执行的是系统的 sendAction 方法
    [self newSendAction:action to:target forEvent:event];
}

//解除限制
- (void)resetState{
    [self setIsIgnoreEvent:NO];
}

@end
