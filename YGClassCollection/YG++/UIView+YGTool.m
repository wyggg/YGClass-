//
//  UIView+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/16.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import "UIView+YGTool.h"
#import "NSString+YGTool.h"
#import <objc/runtime.h>


@implementation UIView (YGTool)


+ (UIWindow *)mainWindow{
    return [[UIApplication sharedApplication].delegate window];
}
+ (UIViewController *)rootViewController{
    return [[UIApplication sharedApplication].delegate window].rootViewController;
}

#pragma mark - 边框

//设置边框
- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color{
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 1.0;
}

//切割圆角
- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    self.layer.masksToBounds = cornerRadius>0;
}

///任意方向设置圆角
- (void)setCornerRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)byRoundingCorners{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                     byRoundingCorners:byRoundingCorners
                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

///顶边圆角
- (void)setCornerOnTopRadius:(CGFloat)cornerOnTopRadius{
    [self setCornerRadius:cornerOnTopRadius byRoundingCorners:(UIRectCornerTopLeft|UIRectCornerTopRight)];
}

///底边圆角
- (void)setCornerOnBottomRadius:(CGFloat)cornerOnBottomRadius{
    [self setCornerRadius:cornerOnBottomRadius byRoundingCorners:(UIRectCornerBottomLeft|UIRectCornerBottomRight)];
}


#pragma mark - 常用GET

//获得view上所有子视图
- (NSArray *)allSubviews {
    NSArray *results = [self subviews];
    for (UIView *eachView in [self subviews]) {
        NSArray *riz = eachView.allSubviews;
        if (riz) {
            results = [results arrayByAddingObjectsFromArray:riz];
        }
    }
    return results;
}

//获得当前view的所在的ViewController
- (UIViewController *)viewController{
    UIResponder *nextResponder =  self;
    do{
        nextResponder = [nextResponder nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController*)nextResponder;
        
    } while (nextResponder != nil);
    return nil;
}

//获得当前屏幕最顶层的ViewController
- (UIViewController *)topMostController{
    NSMutableArray *controllersHierarchy = [[NSMutableArray alloc] init];
    UIViewController *topController = self.window.rootViewController;
    if (topController){
        [controllersHierarchy addObject:topController];
    }
    
    while ([topController presentedViewController]) {
        topController = [topController presentedViewController];
        [controllersHierarchy addObject:topController];
    }
    
    UIResponder *matchController = [self viewController];
    
    while (matchController != nil && [controllersHierarchy containsObject:matchController] == NO)
    {
        do
        {
            matchController = [matchController nextResponder];
            
        } while (matchController != nil && [matchController isKindOfClass:[UIViewController class]] == NO);
    }
    return (UIViewController*)matchController;
}

///移除所有视图
- (void)removeAllSubview{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark - 添加下划线

///快速向当前View添加一根下划线
- (UIView *)addBottomLintH:(CGFloat)h color:(UIColor *)color{
   return [self addBottomLintH:h color:color left:0 right:0 bottom:0];
}

///向当前View添加一根下划线
- (UIView *)addBottomLintH:(CGFloat)h color:(UIColor *)color left:(CGFloat)left right:(CGFloat)right bottom:(CGFloat)bottom{
    UIView *view = [self viewWithTag:77367];
    if (view&&view.superview==self) {
        [view removeFromSuperview];
    }
    UIView *line = [[UIView alloc] init];
    line.tag = 77367;
    line.backgroundColor = color;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-bottom);
        make.height.offset(h);
        make.left.offset(left);
        make.right.offset(-right);
    }];
    return line;
}

- (UIView *)addBottomDottedLineLintH:(CGFloat)h color:(UIColor *)color lengths:(NSString *)lengths left:(CGFloat)left right:(CGFloat)right bottom:(CGFloat)bottom{
   
   UIView *view = [self viewWithTag:77367];
   if (view&&view.superview==self) {
      [view removeFromSuperview];
   }
   
    YGLintView *lintView = [[YGLintView alloc] init];
    lintView.backgroundColor = [UIColor clearColor];
    lintView.tag = 77367;
    lintView.lineColor = color;
    lintView.lineDirection = YGLineViewDirection_transverse;
    lintView.lintType = YGLineViewTypeDottedLine;
    lintView.lengths = lengths;
    [self addSubview:lintView];
    [lintView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-bottom);
        make.height.offset(h);
        make.left.offset(left);
        make.right.offset(-right);
    }];
    
   return nil;
}

///删除下划线
- (void)removeBottomLint{
    UIView *line = [self viewWithTag:77367];
    [line removeFromSuperview];
}

///删除所有下划线
- (void)removeAllLine{
   for (UIView *view in self.allSubviews) {
      if (view.tag ==77367) {
         [view removeFromSuperview];
      }
   }
}


#pragma mark - UIView快速添加角标
static int numBar_ = 0;

///添加角标
- (void)setNumBar:(int)numBar{
    numBar_ = numBar;
    NSString *numText = @"";
    if (numBar>99) {
        numText = @"99+";
    }else if (numBar<=0){
        numText = @"";
    }else{
        numText = [NSString stringWithFormat:@"%d",numBar];
    }
    
    UILabel *numLabel = [self viewWithTag:12333773];
    if (numLabel == nil) {
        numLabel = [[UILabel alloc] init];
        numLabel.tag = 12333773;
        numLabel.font = [UIFont systemFontOfSize:12];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.backgroundColor = [UIColor redColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numLabel];
    }
    
    CGSize textSize = [numText textSize:CGSizeMake(0, 0) fontSize:numLabel.font.pointSize];
    [numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_top).offset(textSize.height/2);
        make.left.equalTo(self.mas_right).offset(-textSize.width/2);
        
        make.height.offset(textSize.height+4);
        if (textSize.width<textSize.height) {
            make.width.offset(textSize.height+4);
        }else if (textSize.width>textSize.height*2.5){
            make.width.offset(textSize.height*2.5);
        }else{
            make.width.offset(textSize.width+4);
        }
    }];
    numLabel.layer.cornerRadius = (textSize.height+4)/2;
    numLabel.layer.masksToBounds = YES;
    numLabel.text = numText;
    numLabel.hidden = !(BOOL)numText.length;
    
}

///设置角标颜色
- (void)setNumBkColor:(UIColor *)color{
    UILabel *numLabel = [self viewWithTag:12333773];
    numLabel.backgroundColor = color;
}
///设置角标文字颜色
- (void)setNumTextColor:(UIColor *)color{
    UILabel *numLabel = [self viewWithTag:12333773];
    numLabel.textColor = color;
}
///设置角标字体
- (void)setNumTextFont:(UIFont *)font{
    UILabel *numLabel = [self viewWithTag:12333773];
    numLabel.font = font;
    [self setNumBar:numBar_];
}
///设置角标位置
- (void)setNumViewConstraint:(void(^)(MASConstraintMaker *))block{
    UILabel *numLabel = [self viewWithTag:12333773];
    [numLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(make);
        }
    }];
}
///移除角标
- (void)removeNumBar{
    UILabel *numLabel = [self viewWithTag:12333773];
    [numLabel removeFromSuperview];
}


#pragma mark - 添加模糊效果
///添加模糊
- (void)addFuzzyViewStype:(UIBlurEffectStyle)stype animate:(BOOL)animate{
    if ([self viewWithTag:7736788]) {
        return;
    }
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:stype];
    UIVisualEffectView *subEffectView = [[UIVisualEffectView alloc]initWithEffect:blur];
    subEffectView.tag = 7736788;
    [self addSubview:subEffectView];
    [subEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    if (animate) {
        subEffectView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            subEffectView.alpha = 1;
        }];
    }
}

///移除模糊
- (void)removeFuzzyViewAnimate:(BOOL)animate{
    __weak typeof(self) aSelf = self;
    UIVisualEffectView *subEffectView = [self viewWithTag:7736788];
    if (animate) {
        [UIView animateWithDuration:0.3 animations:^{
            aSelf.alpha = 0;
        } completion:^(BOOL finished) {
            if (finished) [subEffectView removeFromSuperview];
        }];
    }else{
        [subEffectView removeFromSuperview];
    }
}


#pragma mark - 手势

//键盘手势
- (void)addGestureDismissKeyboard{
    //添加键盘下落手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self addGestureRecognizer:tap];
}
- (void)dismissKeyboard{
    [self endEditing:YES];
}

///添加单击手势
- (void)addTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:tapGesture];
}

#pragma mark - 截图

///截图
- (UIImage *)viewScreenShot{
    return [self viewScreenShotInFrame:self.layer.bounds];
}

//截图
- (UIImage *)viewScreenShotInFrame:(CGRect)frame{
    CALayer *layer = self.layer;
    UIGraphicsBeginImageContextWithOptions(frame.size, layer.opaque, 0.0f);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end


#pragma mark - Xib工具类
@implementation UIView (YGTool_Xib)

#pragma mark - Xib

///从xib加载一个view
+ (instancetype)viewFromXib{
    return [self viewFromNibName:NSStringFromClass(self)];
}

///从xib加载一个view
+ (instancetype)viewFromNibName:(NSString *)name{
    return [[[NSBundle mainBundle] loadNibNamed:name owner:nil options:nil]lastObject];
}

///获得一个xib文件中与自己类型相同的View
+ (instancetype)getXibView:(NSString *)name{
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
    for (UIView *view in views) {
        if ([view isKindOfClass:self]) {
            return view;
        }
    }
    NSLog(@"⚠️ 没有从 %@.nib 中找到 %@ 类型的View",name,self);
    return nil;
}

@end


#pragma mark - Frame工具类
@implementation UIView (YGTool_Frame)

//absoluteFrame:相对于屏幕坐标系的frame
- (CGRect)absoluteFrame{
    return [self convertRect:self.bounds toView:nil];
}

- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.width;
}
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
@end


#pragma mark - 动画操作类
@implementation UIView (YGTool_Animation)

///从中央弹出
- (void)springingAnimation
{
    [NSValue valueWithCGRect:CGRectMake(0, 0, 0, 0)];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.layer addAnimation:popAnimation forKey:nil];
}

///摆动
- (void)shakeAnimation{
    [self shakeAnimationCount:3 amplitude:8.0f duration:0.08f];
}

///摆动
- (void)shakeAnimationCount:(float)count amplitude:(CGFloat)amplitude duration:(CGFloat)duration {
    
    CALayer* layer = [self layer];
    CGPoint position = [layer position];
    CGPoint y = CGPointMake(position.x - amplitude, position.y);
    CGPoint x = CGPointMake(position.x + amplitude, position.y);
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setTimingFunction:[CAMediaTimingFunction
                                  functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [animation setFromValue:[NSValue valueWithCGPoint:x]];
    [animation setToValue:[NSValue valueWithCGPoint:y]];
    [animation setAutoreverses:YES];
    [animation setDuration:duration];
    [animation setRepeatCount:count];
    [layer addAnimation:animation forKey:nil];
}

@end



@implementation YGLintView

- (void)startDrawInType:(YGLineViewType)type{
    _lintType = type;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
   [super drawRect:rect];
   //虚线

   if (_lintType==YGLineViewTypeDottedLine) {
       
       NSArray *numStrs = [self.lengths componentsSeparatedByString:@","];
      CGFloat lengths[2];
       for (int i=0; i<2; i++) {
           if (numStrs.count<2) {
               lengths[i] = 1;
           }else{
               lengths[i] = [numStrs[i] floatValue];
           }
       }
       
      [self drawDottedLineWithCGColor:self.lineColor.CGColor
                            direction:self.lineDirection
                              lengths:lengths];
       

//       [self drawDottedLineWithCGColor:[UIColor yellowColor].CGColor
//                             direction:YGLineViewDirection_transverse
//                               lengths:lengths];
   }
}

///绘制虚线代码
- (void)drawDottedLineWithCGColor:(CGColorRef)color direction:(YGLineViewDirection)direction lengths:(CGFloat[])lengths{
   
   CGContextRef currentContext = UIGraphicsGetCurrentContext();
   //设置虚线颜色
   CGContextSetStrokeColorWithColor(currentContext, color);
   
   CGPoint startPoint;
   CGPoint endPoint;
   if (direction==YGLineViewDirection_longitudinal) {
      startPoint = CGPointMake(self.center.x, 0);
      endPoint = CGPointMake(self.center.x, self.frame.origin.y + self.frame.size.height);
      CGContextSetLineWidth(currentContext, self.frame.size.width); //1
   }else{
      startPoint = CGPointMake(0, 0);
      endPoint = CGPointMake(self.frame.origin.x + self.frame.size.width, 0);
      CGContextSetLineWidth(currentContext, self.frame.size.height*2); //1
   }
   
   //设置虚线绘制起点
   CGContextMoveToPoint(currentContext, startPoint.x, startPoint.y);
   //设置虚线绘制终点
   CGContextAddLineToPoint(currentContext, endPoint.x, endPoint.y);
   //设置虚线排列的宽度间隔:下面的arr中的数字表示先绘制3个点再绘制1个点
   //下面最后一个参数“2”代表排列的个数。
   CGContextSetLineDash(currentContext, 0, lengths, 2);
   CGContextDrawPath(currentContext, kCGPathStroke);

}

@end
