//
//  YGItemsView.h
//  OverseasEstate
//
//  Created by 吴港 on 2017/9/14.
//  Copyright © 2017年 NQKJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGItemsViewCell.h"
#import "YGEqualSpaceFlowLayout.h"

@class YGItemsView;

/*
 collectionview的封装 使用本类可以快速创建按钮组合，标签集合等，如果太复杂，还是直接用collectionView吧
 */

///按钮组合视图的封装
@interface YGItemsView : UIView

///数据源
@property (nonatomic, strong) NSArray *cellectionViewDataSource;
@property (nonatomic, assign) BOOL automaticH; //自动计算视图的高度

//控件
@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, strong) YGEqualSpaceFlowLayout *layout;

///代理回调
@property (nonatomic, copy) CGSize(^sizeForItemAtIndexBlock)(YGItemsView *,NSInteger);
@property (nonatomic, copy) YGItemsViewCell *(^cellForItemAtIndexBlock)(YGItemsView *,NSInteger,YGItemsViewCell *);
@property (nonatomic, copy) void(^celldidSelectBlock)(YGItemsView *,NSInteger);

///加载视图
- (void)loadCollectionView;

///工具 计算字符串size
- (CGSize)calculateSizeToText:(NSString *)text font:(UIFont *)font size:(CGSize)size;


@end


///使用示例
/*
YGItemsView *groupItemsView = [[YGItemsView alloc] init];
self.groupCellsView = groupItemsView;
groupItemsView.layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
groupItemsView.layout.cellType = YGEqualSpaceFlowLayoutAlignTypeLeft;
groupItemsView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
groupItemsView.layout.betweenOfCell = 10;
groupItemsView.layout.itemSize = CGSizeMake(60, 80);
[groupItemsView loadCollectionView];
groupItemsView.automaticH = YES;

//设置cell
[groupItemsView setCellForItemAtIndexBlock:^YGItemsViewCell *(YGItemsView *v, NSInteger i, YGItemsViewCell *c) {
    
    GroupItemView *cellView = [c setupCustomView:[GroupItemView class]];
    ChatUserCacheModel *cacheModel = v.cellectionViewDataSource[i];
    if ([cacheModel isKindOfClass:[NSString class]]) {
        cellView.nickNameLabel.text = @"";
        NSString *str = (NSString *)cacheModel;
        if ([str isEqualToString:kADD_BUTTON_KEY]) {
            cellView.imageView.image = @"jiahao".image;
        }else{
            cellView.imageView.image = @"jianhao".image;
        }
    }else{
        [cellView.imageView sd_setImageWithURL:cacheModel.headImage.URL placeholderImage:nil];
        cellView.nickNameLabel.text = cacheModel.nickName;
    }
    cellView.vipImageView.hidden = (i!=0);
    
    return c;
}];
K_WEAK_SELF_aSelf
///item点击
[groupItemsView setCelldidSelectBlock:^(YGItemsView *v, NSInteger i) {
    ChatUserCacheModel *cacheModel = v.cellectionViewDataSource[i];
    if ([cacheModel isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)cacheModel;
        if ([str isEqualToString:kADD_BUTTON_KEY]) {
            [aSelf addMembers];
        }else{
            [aSelf removeMembers];
        }
    }else{
        //跳转 好友详情
        FruendsInfoVC *vc = [[FruendsInfoVC alloc] init];
        vc.ID = cacheModel.chatID;
        [aSelf.navigationController pushViewController:vc animated:YES];
    }
}];
[tbHeadView addSubview:groupItemsView];
[groupItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.offset(0);
    make.right.offset(0);
    make.top.equalTo(titleNameView.mas_bottom).offset(5);
    make.height.offset(0);
}];
*/
