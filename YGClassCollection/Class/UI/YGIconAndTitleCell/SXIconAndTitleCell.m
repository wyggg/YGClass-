//
//  SXIconAndTitleCell.m
//  高薪工资
//
//  Created by yggggg on 2017/8/2.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import "SXIconAndTitleCell.h"
#import <Masonry.h>

///箭头图片的名称
#define kARROW_IMAGE_NAME @""

@implementation SXIconAndTitleCell

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self loadUI];
    }
    return self;
}

- (UIView *)rightImageView{
    if (!_rightImageView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        _rightImageView = imageView;
        [self.contentView addSubview:imageView];
        [_rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.noteLabel.mas_right);
            make.size.mas_equalTo(self.rightImageViewSize);
            make.centerY.offset(0);
        }];
        
    }
    return _rightImageView;
}

- (UISwitch *)switchButton{
    if (!_switchButton) {
        UISwitch *switchBtn = [[UISwitch alloc] init];
        _switchButton = switchBtn;
        [self.contentView addSubview:switchBtn];
        [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.offset(0);
            make.width.offset(50);
            make.height.offset(31);
        }];
    }
    return _switchButton;
}

- (void)loadUI{
    
//    @property (nonatomic, weak) UIImageView *iconImageView;  //图标
//    @property (nonatomic, weak) UILabel *titleLabel;         //标题
//    @property (nonatomic, weak) UIImageView *titleToImage;   //标题后小图标
//    @property (nonatomic, weak) UILabel *noteLabel;          //标题附加文字
//    @property (nonatomic, weak) UIImageView *aImageView;     //箭头
    
    UIImageView *iconImageVIew= [[UIImageView alloc] init];
//    iconImageVIew.backgroundColor = kColor_BackgroudGray;
    self.iconImageView = iconImageVIew;
    [self.contentView addSubview:iconImageVIew];
    [iconImageVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.height.width.equalTo(self.contentView.mas_height).multipliedBy(0.8);
        make.centerY.offset(0);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel = titleLabel;
    [self.contentView addSubview:titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImageVIew.mas_right).offset(10);
        make.top.offset(0);
        make.bottom.offset(0);
    }];
    
    UIImageView *titleToImage = [[UIImageView alloc] init];
    self.titleToImage = titleToImage;
//    titleToImage.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:titleToImage];
    [titleToImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(10);
        make.centerY.offset(0);
        make.left.equalTo(titleLabel.mas_right).offset(5);
    }];
    
    
    UIImageView *aImageView = [[UIImageView alloc] init];
    self.aImageView = aImageView;
    aImageView.image = [UIImage imageNamed:kARROW_IMAGE_NAME];
//    aImageView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:aImageView];
    [aImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(20);
        make.centerY.offset(0);
        make.right.offset(-15);
    }];
    
    UILabel *noteLabel = [[UILabel alloc] init];
    self.noteLabel = noteLabel;
    noteLabel.numberOfLines = 0;
    noteLabel.textColor = [UIColor lightTextColor];
    noteLabel.font = [UIFont systemFontOfSize:12];
    noteLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:noteLabel];
    [noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(aImageView.mas_left).offset(-5);
        make.centerY.offset(0);
    }];
    
//    [self.contentView addBottomLintH:0.5 color:kColor_LineGray];
    
}

- (void)setIconSize:(CGSize)iconSize{
    _iconSize = iconSize;
    [_iconImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(15);
        make.centerY.offset(0);
        make.size.mas_equalTo(self.iconSize);
    }];
}

- (void)setIsHiddenIconImageView:(BOOL)isHiddenIconImageView{
    if (_isHiddenIconImageView == isHiddenIconImageView) {
        return;
    }
    _isHiddenIconImageView = isHiddenIconImageView;
    self.iconImageView.hidden = _isHiddenIconImageView;
    
    if (_isHiddenIconImageView) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
    }else{
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImageView.mas_right).offset(10);
            make.top.offset(0);
            make.bottom.offset(0);
        }];
    }
}

- (void)setIsHiddenArrowImageView:(BOOL)isHiddenArrowImageView{
    _isHiddenArrowImageView = isHiddenArrowImageView;
    
    self.aImageView.hidden = _isHiddenArrowImageView;
    if (_isHiddenArrowImageView) {
        [self.noteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-15);
            make.centerY.offset(0);
        }];
    }else{
        [self.noteLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.aImageView.mas_left).offset(-5);
            make.centerY.offset(0);
        }];
    }
}



@end
