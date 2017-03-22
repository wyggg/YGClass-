//
//  UIView+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/16.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#pragma mark - YGTool
@interface UIView (YGTool)

///获得当前View所有层级的子视图 所有视图的指针都可以找到
@property (nonatomic, weak, readonly) NSArray *allSubviews;

///获得当前View所有父视图 包括父视图的父视图
@property (nonatomic, weak, readonly) NSArray <UIView *>*allSuperViews;

///获得当前view的所在的ViewController
@property (nonatomic, weak, readonly) UIViewController *viewController;

///获得屏幕View最顶层的ViewController
@property (nonatomic, weak, readonly) UIViewController *topMostController;

///获得主window
+ (UIWindow *)mainWindow;
+ (UIViewController *)rootViewController;

///设置view边框
- (void)setBorderWidth:(CGFloat)width color:(UIColor *)color;
///设置view圆角
- (void)setCornerRadius:(CGFloat)cornerRadius;

///任意方向圆角 byRoundingCorners:方向
- (void)setCornerRadius:(CGFloat)cornerRadius
      byRoundingCorners:(UIRectCorner)byRoundingCorners;
- (void)setCornerOnBottomRadius:(CGFloat)cornerOnBottomRadius;
- (void)setCornerOnTopRadius:(CGFloat)cornerOnTopRadius;

///移除全部子视图
- (void)removeAllSubview;

///快速向当前View添加一根下划线
- (UIView *)addBottomLintH:(CGFloat)h color:(UIColor *)color;
///向当前View添加一根下划线
- (UIView *)addBottomLintH:(CGFloat)h color:(UIColor *)color left:(CGFloat)left right:(CGFloat)right bottom:(CGFloat)bottom;
///向当前View添加一根虚线 lengths = @"1,1"
- (UIView *)addBottomDottedLineLintH:(CGFloat)h
                               color:(UIColor *)color
                             lengths:(NSString *)lengths
                                left:(CGFloat)left right:(CGFloat)right
                              bottom:(CGFloat)bottom;
///删除下划线
- (void)removeBottomLint;
///删除所有下划线
- (void)removeAllLine;


#pragma mark - UIView快速添加角标
///添加按钮角标
- (void)setNumBar:(int)numBar;
///设置角标颜色
- (void)setNumBkColor:(UIColor *)color;
///设置角标文字颜色
- (void)setNumTextColor:(UIColor *)color;
///设置角标字体
- (void)setNumTextFont:(UIFont *)font;
///设置角标位置
- (void)setNumViewConstraint:(void(^)(MASConstraintMaker *))block;
///移除角标
- (void)removeNumBar;


///添加模糊
- (void)addFuzzyViewStype:(UIBlurEffectStyle)stype animate:(BOOL)animate;
///移除模糊
- (void)removeFuzzyViewAnimate:(BOOL)animate;

///绑定单击事件
- (void)addTarget:(id)target action:(SEL)action;
///添加键盘下落手势
- (void)addGestureDismissKeyboard;

///截图
- (UIImage *)viewScreenShot;
///截图 frame：范围
- (UIImage *)viewScreenShotInFrame:(CGRect)frame;

@end

#pragma mark - Xib 工具类
@interface UIView (YGTool_Xib)

///从xib加载一个view（xib名字需与类名相同）
+ (instancetype)viewFromXib;
///从xib加载一个view name：xib文件名
+ (instancetype)viewFromNibName:(NSString *)name;
///从Xib中获得自身类型的View （一个Xib文件中存在多个View的情况下适用）
+ (instancetype)getXibView:(NSString *)name;

@end

#pragma mark - Frame 工具类
@interface UIView (YGTool_Frame)

///相对屏幕的绝对位置
@property (nonatomic, readonly) CGRect absoluteFrame;

@property (nonatomic) CGFloat left;    //x
@property (nonatomic) CGFloat top;     //y
@property (nonatomic) CGFloat width;   //w
@property (nonatomic) CGFloat height;  //h
@property (nonatomic) CGFloat right;   //x+w
@property (nonatomic) CGFloat bottom;  //y+h
@property (nonatomic) CGFloat centerX; //x+w/2
@property (nonatomic) CGFloat centerY; //y+h/2
@property (nonatomic) CGPoint origin;  //(x,y)
@property (nonatomic) CGSize  size;    //(w,h)

@end

#pragma mark - 动画操作类
@interface UIView (YGTool_Animation)

///从中央弹出
- (void)springingAnimation;

///摆动动画（摇头）
- (void)shakeAnimation;

///摆动动画（摇头） count：摆动次数  amplitude：摆动幅度  duration：每次摆动持续时间
- (void)shakeAnimationCount:(float)count amplitude:(CGFloat)amplitude duration:(CGFloat)duration;

@end

#pragma mark - LintView

@interface YGLintView : UIView

///线的方向
typedef NS_ENUM(int ,YGLineViewDirection){
    YGLineViewDirection_transverse = 1,  //横向
    YGLineViewDirection_longitudinal = 2,//纵向
};

///线的类型
typedef NS_ENUM(int ,YGLineViewType){
    YGLineViewTypeDottedLine = 0     //虚线
};

@property (nonatomic, assign) YGLineViewType lintType;
@property (nonatomic, assign) YGLineViewDirection lineDirection;

@property (nonatomic, strong) UIColor *lineColor;

//虚线相关
//间距数组 格式 "1,3"
@property (nonatomic, strong) NSString *lengths;

///重绘视图
- (void)startDrawInType:(YGLineViewType)type;

@end
