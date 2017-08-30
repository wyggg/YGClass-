//
//  SXNavigationView.h
//  高薪工资
//
//  Created by yggggg on 2017/8/1.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SXNavigationBarButton;

#define kNavigationView_TitleColor [UIColor lightTextColor] //标题颜色
#define kNavigationView_LineColor [UIColor lightTextColor]  //导航底线颜色

///假导航的封装 如果项目中要用到假导航可直接用这个控件
@interface SXNavigationView : UIView


@property (nonatomic, weak)   UILabel               *titleLabel;
@property (nonatomic, weak)   UIImageView           *backgroundImageView;

@property (nonatomic, weak)   SXNavigationBarButton                    *leftButton;
@property (nonatomic, strong) NSMutableArray <SXNavigationBarButton *> *rightButtons;
@property (nonatomic, weak)   UIView *bottomLine;

@property (nonatomic, assign) BOOL hiddenBackButton;

///添加按钮(简易 图片)
- (SXNavigationBarButton *)addrightButtonInIcon:(UIImage *)icon
                                      imageSize:(CGSize)imageSize;

///添加按钮(简易 文字)
- (SXNavigationBarButton *)addrightButtonInTitle:(NSString *)title
                                         spacing:(CGFloat)spacing
                                            size:(CGSize)size;

///添加按钮(文字+图片)
- (SXNavigationBarButton *)addrightButtonInTitle:(NSString *)title
                                            icon:(UIImage *)icon
                                       touchSize:(CGSize)touchSize
                                       imageSize:(CGSize)imageSize
                                         spacing:(CGFloat)spacing
                                             tag:(NSInteger)tag;

///通过Tag值移除一个按钮
- (void)removeRightButtonInTag:(NSInteger)tag;

@end

///独立的导航按钮
@interface SXNavigationBarButton : UIView

@property (nonatomic, weak) UILabel     *titleLabel;
@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, assign) CGSize    imageSize;

- (id)initWithImageSize:(CGSize)imageSize;
- (SXNavigationBarButton *)addTarget:(id)target action:(SEL)action;

@end
