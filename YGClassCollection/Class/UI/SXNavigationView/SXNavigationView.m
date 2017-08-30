//
//  SXNavigationView.m
//  高薪工资
//
//  Created by yggggg on 2017/8/1.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import "SXNavigationView.h"
#import <Masonry.h>
#import "UIView+YGTool.h"

@implementation SXNavigationView

- (id)init{
    if (self = [super init]) {
        
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    [self addSubview:backgroundImageView];
    [backgroundImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    self.titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = kNavigationView_TitleColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(0);
        make.top.offset(20);
        make.left.offset(0);
        make.right.offset(0);
    }];
    
    SXNavigationBarButton *leftButton = [[SXNavigationBarButton alloc] initWithImageSize:CGSizeMake(18, 18)];
    self.leftButton = leftButton;
    leftButton.imageView.image = [UIImage imageNamed:@"return-1"];
    [self addSubview:leftButton];
    [leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.width.offset(64);
        make.height.offset(64-21);
        make.top.offset(20);
    }];
    
   self.bottomLine = [self addBottomLintH:0.5 color:kNavigationView_LineColor];
    
}

- (SXNavigationBarButton *)addrightButtonInIcon:(UIImage *)icon
                                       imageSize:(CGSize)imageSize{
    return [self addrightButtonInTitle:nil icon:icon touchSize:CGSizeMake(30, 64-21) imageSize:imageSize spacing:10 tag:0];
}

///向右侧添加一个按钮(纯文字 简易)
- (SXNavigationBarButton *)addrightButtonInTitle:(NSString *)title
                                         spacing:(CGFloat)spacing
                                            size:(CGSize)size{
    
   return [self addrightButtonInTitle:title
                                 icon:nil
                            touchSize:size
                            imageSize:CGSizeMake(0, 0)
                              spacing:spacing
                                  tag:0];
}

- (SXNavigationBarButton *)addrightButtonInTitle:(NSString *)title
                         icon:(UIImage *)icon
                    touchSize:(CGSize)touchSize
                    imageSize:(CGSize)imageSize
                      spacing:(CGFloat)spacing
                          tag:(NSInteger)tag{
    if (!_rightButtons) {
        self.rightButtons = [NSMutableArray array];
    }
    
    SXNavigationBarButton *reighButton = [[SXNavigationBarButton alloc] initWithImageSize:imageSize];
    reighButton.tag = tag;
    if (title) {
        reighButton.titleLabel.text = title;
    }
    if (icon) {
        reighButton.imageView.image = icon;
    }
    
//    reighButton.imageView.backgroundColor = [UIColor redColor];
//    reighButton.backgroundColor = [UIColor yellowColor];
    [self addSubview:reighButton];
    
    SXNavigationBarButton *toView = [_rightButtons lastObject];
    [reighButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (toView) {
            make.right.equalTo(toView.mas_left).offset(-spacing);
        }else{
            make.right.offset(-spacing);
        }

        make.width.offset(touchSize.width);
        make.height.offset(touchSize.height-1);
        make.centerY.offset(20/2);
    }];
    
    [self.rightButtons addObject:reighButton];
    
    return reighButton;
}

///通过Tag值移除一个按钮
- (void)removeRightButtonInTag:(NSInteger)tag{
    UIView *weView = nil;
    UIView *reView = nil;
    for (UIView *view in self.rightButtons) {
        if ([view isKindOfClass:SXNavigationBarButton.class]) {
            if (view.tag == tag) {
                [view removeFromSuperview];
                reView = view;
                return;
            }
        }
        weView = view;
    }
    [self.rightButtons removeObject:(id)reView];
}

- (void)setHiddenBackButton:(BOOL)hiddenBackButton{
    _hiddenBackButton = hiddenBackButton;
    self.leftButton.hidden = _hiddenBackButton;
}

@end



@implementation SXNavigationBarButton

- (id)initWithImageSize:(CGSize)imageSize{
    if (self = [super init]) {
        self.imageSize = imageSize;
    }
    return self;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 1;
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:label];
        _titleLabel = label;
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        
        [self layerTextAndImage];
    }
    return _titleLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _imageView = imageView;
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.imageSize);
            make.center.offset(0);
        }];
        
        [self layerTextAndImage];
    }
    return _imageView;
}

- (void)layerTextAndImage{
    
    if (_imageView && _titleLabel) {
        
        [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(self.imageSize);
            make.centerX.offset(0);
            make.centerY.offset(-self.imageSize.height/2);
        }];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(0);
            make.right.offset(0);
            make.centerX.offset(0);
            make.centerY.offset(self.imageSize.height/2);
        }];
        
    }
}

- (SXNavigationBarButton *)addTarget:(id)target action:(SEL)action{
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    [self addGestureRecognizer:tapGesture];
    return self;
}


@end
