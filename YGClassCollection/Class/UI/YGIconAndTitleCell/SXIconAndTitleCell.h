//
//  SXIconAndTitleCell.h
//  高薪工资
//
//  Created by yggggg on 2017/8/2.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import <UIKit/UIKit.h>



///多功能 图标 标题组合的CollectionViewCell  一般用在个人中心等页面
@interface SXIconAndTitleCell : UICollectionViewCell

@property (nonatomic, weak) UIImageView *iconImageView;  //图标
@property (nonatomic, weak) UILabel *titleLabel;         //标题
@property (nonatomic, weak) UIImageView *titleToImage;   //标题后小图标
@property (nonatomic, weak) UILabel *noteLabel;          //标题附加文字
@property (nonatomic, weak) UIImageView *aImageView;     //箭头

//懒加载的控件
@property (nonatomic, assign)  CGSize rightImageViewSize;
@property (nonatomic, weak)    UIImageView *rightImageView;
@property (nonatomic, weak)    UISwitch    *switchButton;

//参数
@property (nonatomic, assign) CGSize iconSize;
//隐藏左边图片框
@property (nonatomic, assign) BOOL   isHiddenIconImageView;
//隐藏右边箭头
@property (nonatomic, assign) BOOL   isHiddenArrowImageView;

@end
