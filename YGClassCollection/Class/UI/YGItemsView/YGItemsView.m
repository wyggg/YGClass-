//
//  YGItemsView.m
//  OverseasEstate
//
//  Created by 吴港 on 2017/9/14.
//  Copyright © 2017年 NQKJ. All rights reserved.
//

#import "YGItemsView.h"
#import "YGItemsViewCell.h"
#import <Masonry.h>

@interface YGItemsView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

///储存item的Size
@property (nonatomic, strong) NSMutableDictionary *itemSizeDic;

@end

@implementation YGItemsView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setCellectionViewDataSource:(NSArray *)cellectionViewDataSource{
    _cellectionViewDataSource = cellectionViewDataSource;
    [self.collectionView reloadData];
}

///懒加载布局类
- (YGEqualSpaceFlowLayout *)layout{
    if (!_layout) {
        YGEqualSpaceFlowLayout *layout = [[YGEqualSpaceFlowLayout alloc] initWithType:YGEqualSpaceFlowLayoutAlignTypeLeft];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.cellType = YGEqualSpaceFlowLayoutAlignTypeLeft;
        layout.betweenOfCell = 5;
        _layout = layout;
    }
    return _layout;
    
}

- (void)loadCollectionView{
    
    if (_collectionView) {
        [_collectionView reloadData];
        return;
    }
    
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:[self layout]];
    self.collectionView = collectionView;
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [collectionView registerClass:[YGItemsViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.cellectionViewDataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.sizeForItemAtIndexBlock) {
        return self.sizeForItemAtIndexBlock(self,indexPath.row);
    }
    return self.layout.itemSize;
}


///计算字符串size
- (CGSize)calculateSizeToText:(NSString *)text font:(UIFont *)font size:(CGSize)size{
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize  actualsize =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    return actualsize;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YGItemsViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (self.cellForItemAtIndexBlock) {
        return self.cellForItemAtIndexBlock(self, indexPath.row, cell);
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.celldidSelectBlock) {
        self.celldidSelectBlock(self, indexPath.row);
    }
}

- (void)setAutomaticH:(BOOL)automaticH{
    _automaticH = automaticH;
    if (_automaticH) {
        [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        [self.collectionView reloadData];
    }else{
        [self.collectionView removeObserver:self forKeyPath:@"contentSize"];
    }
}

- (void)removeFromSuperview{
    [super removeFromSuperview];
    self.automaticH = NO;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    CGSize size = [change[NSKeyValueChangeNewKey] CGSizeValue];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(size.height);
    }];
}

@end
