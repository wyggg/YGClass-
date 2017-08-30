//
//  NumberChooseView.m
//  高薪工资
//
//  Created by yg on 2017/8/11.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import "NumberChooseView.h"
#import "UIButton+YGTool.h"
#import <Masonry.h>

@implementation NumberChooseView

- (id)init{
    if (self = [super init]) {
        self.buttonSpacing = 1;
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"+" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor redColor] forState:0];
    [addButton setBackgroundColor:[UIColor lightGrayColor] forState:0];
    [addButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    
    addButton.layer.masksToBounds = YES;
    addButton.layer.cornerRadius = 3;
    
    [addButton addTarget:self action:@selector(addButtonEvents) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:addButton];
    self.addButoon = addButton;
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self.mas_height);
        make.centerY.offset(0);
        make.right.offset(0);
    }];
    
    UIButton *reButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [reButton setTitle:@"-" forState:UIControlStateNormal];
    [reButton setTitleColor:[UIColor redColor] forState:0];
    [reButton setBackgroundColor:[UIColor lightGrayColor] forState:0];
    [reButton.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [reButton addTarget:self action:@selector(reButtonEvents) forControlEvents:UIControlEventTouchUpInside];
    
    reButton.layer.masksToBounds = YES;
    reButton.layer.cornerRadius = 3;
    [self addSubview:reButton];
    self.reButton = reButton;
    [reButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height);
        make.width.equalTo(self.mas_height);
        make.centerY.offset(0);
        make.left.offset(0);
    }];
    
    
    UITextField *textField = [[UITextField alloc] init];
    textField.text = @"1";
    textField.backgroundColor = [UIColor lightGrayColor];
    textField.textColor = [UIColor redColor];
    textField.font = [UIFont systemFontOfSize:12];
    textField.textAlignment = NSTextAlignmentCenter;
    
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 3;
    self.textField = textField;
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.mas_height);
        make.right.equalTo(addButton.mas_left).offset(-self.buttonSpacing);
        make.centerY.offset(0);
        make.left.equalTo(reButton.mas_right).offset(self.buttonSpacing);
    }];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:textField];
    
}

- (void)setTextFont:(UIFont *)textFont{
    _textFont = textFont;
    self.textField.font = _textFont;
    self.addButoon.titleLabel.font = _textFont;
    self.reButton.titleLabel.font = _textFont;
}

- (void)textFieldDidEndEditing:(UITextField *)textFiled{
    if (self.textFieldDidEndEditingBlock) {
        self.textFieldDidEndEditingBlock(self);
        ;
    }
}

- (void)addButtonEvents{
    if (self.addButtonEventsBlock) {
        self.addButtonEventsBlock(self);
    }
}

- (void)reButtonEvents{
    if (self.reButtonEventsBlock) {
        self.reButtonEventsBlock(self);
    }
}

@end
