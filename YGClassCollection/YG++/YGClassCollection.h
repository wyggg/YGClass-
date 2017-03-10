//
//  YGClassCollection.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/17.
//  Copyright © 2016年 吴港. All rights reserved.
//

#ifndef YGClassCollection_h
#define YGClassCollection_h

//使用 UIImage+YGTool 需要导入 Accelerate.framework

#import "UIView+YGTool.h"
#import "UIButton+YGTool.h"
#import "UIControl+YGTool.h"
#import "UIImage+YGTool.h"
#import "UIColor+YGTool.h"
#import "NSObject+YGTool.h"
#import "NSString+YGTool.h"
#import "NSTimer+YGTool.h"
#import "NSDate+YGTool.h"

// 快速获取屏幕宽度
#define kScreenW  [UIScreen mainScreen].bounds.size.width
// 快速获取屏幕高度
#define kScreenH  [UIScreen mainScreen].bounds.size.height
// 以6为基准适配宽度
#define kScaleWidth(w)        ((w*1.0)/375.0) * kScreenW
// 以6为基准根据宽度适配高度
#define kScaleHeight(w,h)     ((h*1.0)/(w*1.0)) * ((w*1.0)/375.0) * kScreenW
// 以6位基准获得等比的控件size
#define kScaleSize(w,h)       CGSizeMake(kScaleWidth(w) , kScaleHeight(w,h))

//快速定义弱引用的self指针
#define K_WEAK_SELF(PointerName) __weak typeof(self) PointerName = self;
#define K_WEAK_SELF_aSelf K_WEAK_SELF(aSelf)

//由角度获取弧度 有弧度获取角度
#define kDegreesToRadian(x) (M_PI * (x) / 180.0)
#define kRadianToDegrees(radian) (radian*180.0)/(M_PI)

//NSLog定义
#ifdef DEBUG

# define NSLog(...) NSLog(__VA_ARGS__)

# define YLog(fmt, ...) NSLog((@"<%@:(%d)> \n" fmt "\n\n"),[[NSString stringWithUTF8String:__FILE__] lastPathComponent],__LINE__,##__VA_ARGS__)

# define YLog1(fmt, ...) NSLog((@"\n-  文件：%@"  "\n-  位置：%d 行 \n" "-  函数：%s\n"  "-  日志：" fmt "\n\n"),[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__,__FUNCTION__,##__VA_ARGS__)


#else
# define NSLog(...)
# define  YLog(...)
# define  YLog1(...)
#endif


/// 当前系统版本大于等于某版本
#define IOS_SYSTEM_VERSION_EQUAL_OR_ABOVE(v) (([[[UIDevice currentDevice] systemVersion] floatValue] >= (v))? (YES):(NO))


//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]


#pragma mark - 判断

#if TARGET_OS_IPHONE
//真机
#endif
#if TARGET_IPHONE_SIMULATOR
//模拟器
#endif

#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#endif /* YGClassCollection_h */
