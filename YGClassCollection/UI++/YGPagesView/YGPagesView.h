//
//  YGPagesView.h
//  MoleNotes
//
//  Created by iOS wugang on 17/3/17.
//  Copyright © 2017年 wugang. All rights reserved.
//

#import <UIKit/UIKit.h>

///无限轮播控件 可继承本类实现轮播图，vc容器等功能
@class YGPagesView;

@protocol YGPagesViewDelegate <NSObject>

@optional

//页面滑动时调用
- (void)pagesViewDidScroll:(YGPagesView *)pagesView;

//开始减速时调用
- (void)pagesViewDidEndDragging:(YGPagesView *)pagesView;

//页面切换时调用
- (void)pagesView:(YGPagesView *)pagesView didSelectView:(id)view currIndex:(NSInteger)index;

//布局视图时调用  sortingArray:数组中三个对象  分别是 @[上一个视图 , 当前视图 , 下一个视图]
- (void)pagesView:(YGPagesView *)pagesView layoutSubviews:(NSArray *)sortingArray;

@end

@interface YGPagesView : UIView<UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, assign, readonly)  CGPoint contentOffset;
@property (nonatomic, assign)            NSInteger currIndex;
@property (nonatomic, assign)            id <YGPagesViewDelegate>delegate;

//两种数据源传入方式 如需扩展可增加类别
@property (nonatomic, strong) NSMutableArray <UIViewController *>*viewControllers;
@property (nonatomic, strong) NSMutableArray <UIView *>*views;

@end
