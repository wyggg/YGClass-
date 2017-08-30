//
//  YGImageContentView.m
//  高薪工资
//
//  Created by yg on 2017/8/11.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import "YGImageContentView.h"
#import "YGImageContentItemCell.h"
#import <Masonry.h>

//占位图片
#define kAddItemImage [UIImage imageNamed:@"xiangji"]

@interface YGImageContentView (){
    
    ///图片数据源
    NSMutableArray <YGImageModel *>*_imageArray;
    
}


@end

@implementation YGImageContentView

- (id)init{
    if (self = [super init]) {
        
        self.itemSpacing           = 5;
        self.itemSize              = CGSizeMake(0, 0);
        self.imageMaxNumbar        = NSIntegerMax;
        self.scrollDirection       = UICollectionViewScrollDirectionHorizontal;
        self.addItemBackgroudImage = kAddItemImage;
        
        _imageArray = [NSMutableArray array];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        
        ///自动高度 没有高度时给出自动高度
        if (self.itemSize.width == 0 && self.itemSize.height == 0) {
            self.itemSize = CGSizeMake(self.frame.size.height*1.573, self.frame.size.height);
        }
    }else{
        self.itemSize = _itemSize;
    }
    
    [_collectionView reloadData];
    
    
}

#pragma mark - LoadUI

- (void)installUI{
    if (self.collectionView) {
        [self.collectionView reloadData];
    }else{
        [self loadUI];
        [self.collectionView reloadData];
    }
    
}

- (void)loadUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = self.itemSpacing;
    layout.minimumInteritemSpacing = self.itemSpacing;
    layout.scrollDirection = self.scrollDirection;
    layout.itemSize = self.itemSize;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    [collectionView registerNib:[UINib nibWithNibName:@"YGImageContentItemCell" bundle:nil] forCellWithReuseIdentifier:@"Cell"];
}

#pragma mark - UICollectionView

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return self.itemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return self.itemSpacing;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _imageArray.count >= self.imageMaxNumbar ? _imageArray.count : _imageArray.count + 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return self.itemSize;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YGImageContentItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    if (indexPath.row >= _imageArray.count) {
//        cell.backgroundColor = [UIColor redColor];
        cell.image2.image = self.addItemBackgroudImage;
        cell.editor = NO;
    }else{
        YGImageModel *model = _imageArray[indexPath.row];
//        cell.backgroundColor = [UIColor grayColor];
        cell.image2.image = model.image;
        cell.editor = self.editor;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == _imageArray.count) {
        
        __weak typeof(self) aSelf = self;
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageContentView:addItmeDidTouchAddImageBlock:)]) {
            [aSelf.delegate imageContentView:self addItmeDidTouchAddImageBlock:^(NSArray<UIImage *> *images) {
                [aSelf addImages:images];
            }];
        }
        
    }else{
        
        YGImageModel *model = _imageArray[indexPath.row];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(imageContentView:imageItmeDidTouch:)]) {
            [self.delegate imageContentView:self imageItmeDidTouch:model];
        }
        
    }
}

- (NSArray *)images{
    NSMutableArray *imgArray = [NSMutableArray array];
    for (YGImageModel *model in _imageArray) {
        [imgArray addObject:model.image];
    }
    return [imgArray copy];
}

- (void)setImages:(NSArray *)images{
    NSArray *imageArr = [YGImageModel modelInImages:images startIndex:0];
    _imageArray = imageArr.mutableCopy;
}

- (void)addImages:(NSArray <UIImage *>*)images{
    NSArray *imageArr = [YGImageModel modelInImages:images startIndex:_imageArray.count];
    [_imageArray addObjectsFromArray:imageArr];
    [_collectionView reloadData];
}

- (void)removeImage:(UIImage *)image{
    NSMutableArray *reArray = [NSMutableArray array];
    for (YGImageModel *model in _imageArray) {
        if (model.image == image) {
            [reArray addObject:model];
        }
    }
    for (YGImageModel *model in reArray) {
        [_imageArray removeObject:model];
    }
    [_collectionView reloadData];
}

- (void)removeImageInIndex:(NSInteger)index{
    NSMutableArray *reArray = [NSMutableArray array];
    for (YGImageModel *model in _imageArray) {
        if ([model.index isEqualToString:[NSString stringWithFormat:@"%.0f",(double)index]]) {
            [reArray addObject:model];
        }
    }
    for (YGImageModel *model in reArray) {
        [_imageArray removeObject:model];
    }
    [_collectionView reloadData];
}

- (void)setEditor:(BOOL)editor{
    _editor = editor;
    [self.collectionView reloadData];
}

@end
