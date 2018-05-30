//
//  YGImageContentView.h
//  高薪工资
//
//  Created by yg on 2017/8/11.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGImageModel.h"

@class YGImageContentView;

///添加Image
typedef void(^imageContentViewAddImageBlock)(NSArray <UIImage *>*);

@protocol YGImageContentViewDelegate <NSObject>

///添加图片按钮点击 调用Block添加图片
- (void)imageContentView:(YGImageContentView *)imageContentView addItmeDidTouchAddImageBlock:(imageContentViewAddImageBlock)addImageBlock;

@optional
///图片被单击
- (void)imageContentView:(YGImageContentView *)imageContentView imageItmeDidTouch:(YGImageModel *)model;

@optional

@end

///图片容器控件 (不提供拍照和相册功能)
@interface YGImageContentView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;

///是否进入编辑模式（右上角的X号）
@property (nonatomic, assign) BOOL editor;
///设置图片最大数量
@property (nonatomic, assign) NSInteger imageMaxNumbar;
///选择框大小
@property (nonatomic, assign) CGSize itemSize;
///添加按钮的背景图片
@property (nonatomic, strong) UIImage *addItemBackgroudImage;
///图片之间的间距
@property (nonatomic, assign) CGFloat itemSpacing;
///代理对象
@property (nonatomic, weak) id <YGImageContentViewDelegate>delegate;
///图片滚动方向（当视图范围不足以显示全部图片时将开启滚动）
@property (nonatomic, assign) UICollectionViewScrollDirection scrollDirection;

- (void)installUI;

- (NSArray *)images;

- (void)setImages:(NSArray *)images;
- (void)addImages:(NSArray <UIImage *>*)images;
- (void)removeImage:(UIImage *)image;
- (void)removeImageInIndex:(NSInteger)index;


@end
