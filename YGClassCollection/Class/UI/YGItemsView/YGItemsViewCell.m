//
//  YGItemsViewCell.m
//  OverseasEstate
//
//  Created by 吴港 on 2017/9/14.
//  Copyright © 2017年 NQKJ. All rights reserved.
//

#import "YGItemsViewCell.h"
#import <Masonry.h>

@implementation YGItemsViewCell

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (__kindof  UIView *)setupCustomView:(nullable Class)viewClass{
    
    
//    
//    if ([viewClass isKindOfClass:[UIView class]] == NO) {
//        NSLog(@"不是UIView类型");
//        return nil;
//    }
    
    if (!_customView) {
        UIView *customView = [[viewClass alloc] initWithFrame:self.frame];
        [self.contentView addSubview:customView];
        [customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        _customView = customView;
    }
    
    return _customView;
}

- (void)setupCustomViewWithBlock:(void(^)(UIView *coutomView))block{
    if (!_customView) {
        UIView *customView = [[UIView alloc] initWithFrame:self.frame];
        if (block) {
            block(customView);
        }
        [self.contentView addSubview:customView];
        [customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        _customView = customView;
    }
}
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:self.bounds];
        _label.userInteractionEnabled = NO;
        _label.font = [UIFont systemFontOfSize:10];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    _imageView.hidden = YES;
    _button.hidden = YES;
    return _label;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_imageView];
    }
    _label.hidden = YES;
    _button.hidden = YES;
    return _imageView;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = self.bounds;
        [self.contentView addSubview:_button];
    }
    _label.hidden = YES;
    _imageView.hidden = YES;
    return _button;
}

@end
