//
//  YGMp3PlayView.h
//  Operator
//
//  Created by yg on 2018/1/8.
//  Copyright © 2018年 北京内圈科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGMp3PlayView : UIView

@property (nonatomic, strong) UIImageView *playImageView;
@property (nonatomic, strong) UIView *playProgressView;
@property (nonatomic, strong) UIView *bufferProgressView;
@property (nonatomic, strong) UIView *progressBackgroundView;
@property (nonatomic, strong) UIImageView *scrollButton;
@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, assign) float bufferProgress;
@property (nonatomic, assign) float playProgress;

- (void)close; //关闭
- (void)enable;//启动

@end
