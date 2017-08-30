//
//  YGImageContentItemCell.m
//  高薪工资
//
//  Created by yg on 2017/8/11.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import "YGImageContentItemCell.h"

@implementation YGImageContentItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.image2.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)setEditor:(BOOL)editor{
    _editor = editor;
    [self.image1 setHidden:!_editor];
    [self.image1 setUserInteractionEnabled:_editor];
    if (_editor) {
//        [self.image2 mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.offset(15);
//            make.right.offset(15);
//        }];
    }else{
//        [self.image2 mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.offset(0);
//            make.right.offset(0);
//        }];
    }
}

@end
