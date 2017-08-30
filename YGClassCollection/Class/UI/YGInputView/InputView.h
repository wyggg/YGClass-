//
//  InputView.h
//  MeiDaDaForipad
//
//  Created by iOS 开发 on 16/6/6.
//  Copyright © 2016年 zhangping. All rights reserved.
//

#import <UIKit/UIKit.h>

///长文字输入框的封装
@interface InputView : UIView<UITextViewDelegate>
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) UITextView *textView;

///默认隐藏
@property (nonatomic, strong) UILabel *meslabel;

@property (nonatomic, assign) NSInteger lengthLimit;

@property (nonatomic, strong)  void (^textViewDidEndEditing)(NSString *content);
@property (nonatomic, strong)  void (^textViewDidChange)(NSString *content);

@end
