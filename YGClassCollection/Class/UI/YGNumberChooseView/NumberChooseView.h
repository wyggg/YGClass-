//
//  NumberChooseView.h
//  高薪工资
//
//  Created by yg on 2017/8/11.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import <UIKit/UIKit.h>

///购物车添加删除库存 按钮组的小封装 电商项目经常会用到
@interface NumberChooseView : UIView

@property (nonatomic, assign) CGFloat buttonSpacing;
@property (nonatomic, strong) UIFont* textFont;

@property (nonatomic, weak) UIButton *addButoon;
@property (nonatomic, weak) UIButton *reButton;
@property (nonatomic, weak) UITextField *textField;

///输入框输入完毕
@property (nonatomic, copy) void(^textFieldDidEndEditingBlock)(NumberChooseView *);

///添加按钮点击
@property (nonatomic, copy) void(^addButtonEventsBlock)(NumberChooseView *);

///移除按钮点击
@property (nonatomic, copy) void(^reButtonEventsBlock)(NumberChooseView *);


@end
