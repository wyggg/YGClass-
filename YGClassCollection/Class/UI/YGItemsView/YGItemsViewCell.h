//
//  YGItemsViewCell.h
//  OverseasEstate
//
//  Created by 吴港 on 2017/9/14.
//  Copyright © 2017年 NQKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGItemsViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIView *customView;

///设置自定义视图 只会执行一次 不会重复添加
- (__kindof  UIView *)setupCustomView:(Class)viewClass;
- (void)setupCustomViewWithBlock:(void(^)(UIView *coutomView))block;

@end
