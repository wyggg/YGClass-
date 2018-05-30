//
//  YGEqualSpaceFlowLayout.h
//  OverseasEstate
//
//  Created by 吴港 on 2017/9/17.
//  Copyright © 2017年 NQKJ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,YGEqualSpaceFlowLayoutAlignType){
    YGEqualSpaceFlowLayoutAlignTypeLeft,
    YGEqualSpaceFlowLayoutAlignTypeCenter,
    YGEqualSpaceFlowLayoutAlignTypeRight
};

@interface YGEqualSpaceFlowLayout : UICollectionViewFlowLayout

//cell之间的距离
@property (nonatomic,assign)CGFloat betweenOfCell;
//cell对齐方式
@property (nonatomic,assign)YGEqualSpaceFlowLayoutAlignType cellType;

- (instancetype)initWithType:(YGEqualSpaceFlowLayoutAlignType)cellType;

@end
