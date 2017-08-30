//
//  YGImageContentItemCell.h
//  高薪工资
//
//  Created by yg on 2017/8/11.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGImageContentItemCell : UICollectionViewCell

@property (nonatomic, assign) BOOL editor;

@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;

@end
