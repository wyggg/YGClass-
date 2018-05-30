//
//  SXIconAndTitleCell.h
//  高薪工资
//
//  Created by 吴港gggg on 2017/8/2.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import <UIKit/UIKit.h>

///箭头图片的名称
#define kARROW_IMAGE_NAME @"prev"

///多功能 图标 标题组合的CollectionViewCell  一般用在个人中心等页面
@interface SXIconAndTitleCell : UICollectionViewCell <UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *iconImageView;  //图标
@property (nonatomic, weak) UILabel *titleLabel;         //标题
@property (nonatomic, weak) UIImageView *titleToImage;   //标题后小图标
@property (nonatomic, weak) UILabel *noteLabel;          //标题附加文字
@property (nonatomic, weak) UIImageView *aImageView;     //箭头

//懒加载的控件
@property (nonatomic, assign)  CGSize rightImageViewSize;
@property (nonatomic, weak)    UIImageView *rightImageView;
@property (nonatomic, weak)    UISwitch    *switchButton;


@property (nonatomic, weak)    UITextField *textField;
@property (nonatomic, strong)  void (^textFieldEditingDidBeginBlock)(UITextField *tf);
@property (nonatomic, strong)  void (^textFieldDidEndEditingBlock)(UITextField *tf);
@property (nonatomic, strong)  void (^textFieldDidChangeBlock)(UITextField *tf);

//参数
@property (nonatomic, assign) CGSize iconSize;
//隐藏左边图片框
@property (nonatomic, assign) BOOL   isHiddenIconImageView;
//隐藏右边箭头
@property (nonatomic, assign) BOOL   isHiddenArrowImageView;

@end
