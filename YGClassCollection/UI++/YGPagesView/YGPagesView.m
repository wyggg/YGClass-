//
//  YGPagesView.m
//  MoleNotes
//
//  Created by iOS wugang on 17/3/17.
//  Copyright © 2017年 wugang. All rights reserved.
//

#import "YGPagesView.h"
#import "Masonry.h"

@interface YGPagesView ()

//容器View
@property (nonatomic, strong) NSArray *contentViews;
//内容View
@property (nonatomic, strong) NSMutableArray *contentSubView;
@property (nonatomic, strong) UIView *scrollContentView;
@property (nonatomic, strong) NSMutableArray *sortingArray;


@end

@implementation YGPagesView

@synthesize contentOffset = _contentOffset;

- (id)init{
    if (self = [super init]) {
        self.viewControllers = [NSMutableArray array];
        self.sortingArray = [NSMutableArray array];
        self.contentSubView = [NSMutableArray array];
        [self loadUI];
    }
    return self;
}

- (void)setViewControllers:(NSMutableArray<UIViewController *> *)viewControllers{
    _viewControllers = viewControllers;
    
    if (_viewControllers.count == 0) {
        return;
    }
    
    for (UIView *view in self.contentSubView) {
        [view removeFromSuperview];
    }
    
    self.contentSubView = [NSMutableArray array];
    for (UIViewController *vc in _viewControllers) {
        [self.contentSubView addObject:vc.view];
    }
    
    self.currIndex = 1;
}

- (void)setViews:(NSMutableArray<UIView *> *)views{
    _views = views;
    if (_views.count == 0) {
        return;
    }
    
    for (UIView *view in self.contentSubView) {
        [view removeFromSuperview];
    }
    
    self.contentSubView = [NSMutableArray array];
    for (UIView *view in self.views) {
        [self.contentSubView addObject:view];
    }
    
    self.currIndex = 1;
}

//控制页面
- (void)setCurrIndex:(NSInteger)currIndex{
    
    _currIndex = [self swIndex:currIndex];
    [self.sortingArray removeAllObjects];
    
    for (int i = 0; i <= 2; i++) {
        UIView *vcContentView = _contentViews[i];
        
        NSInteger vcInd = [self swIndex:_currIndex+(i-1)];
        UIView *subView = _contentSubView[vcInd];
        
        //记录排序位置
        [self.sortingArray addObject:subView];
        [vcContentView addSubview:subView];
        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pagesView:layoutSubviews:)]) {
        [self.delegate pagesView:self layoutSubviews:self.sortingArray];
    }
    
}

//返回不会越界的索引
- (NSInteger)swIndex:(NSInteger)currIndex{
    
    NSInteger arrayCtn = _viewControllers.count;
    if (currIndex >= arrayCtn) {
        
        NSInteger index = (currIndex+1) % arrayCtn - 1;
        return [self swIndex:index];
    }
    
    
    if (currIndex < 0){
        NSInteger index = (abs((int)currIndex)+1) % arrayCtn - 1;
        return [self swIndex:self.viewControllers.count - index];
    }
    return currIndex;
}

///基本布局
- (void)loadUI{
    
    ///滑动视图
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.bounces = NO;
    scrollView.delegate = self;
    self.scrollView = scrollView;
    scrollView.backgroundColor = [UIColor orangeColor];
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    [self addSubview:scrollView];
    
    ///滑动视图容器
    UIView *scrollContentView = [[UIView alloc] init];
    scrollContentView.backgroundColor = [UIColor redColor];
    [scrollView addSubview:scrollContentView];
    [scrollContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.centerY.offset(0);
        make.height.equalTo(self.mas_height);
        make.right.offset(0);
    }];
    
    NSMutableArray *viewArray = [NSMutableArray array];
    UIView *toView = nil;
    for (int i = 0; i < 3; i++) {
        
        ///控制器容器视图
        UIView *vcContentView = [[UIView alloc] init];
        [viewArray addObject:vcContentView];
        
        vcContentView.backgroundColor = [UIColor yellowColor];
        [scrollContentView addSubview:vcContentView];
        
        [vcContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (toView == nil) {
                make.left.offset(0);
            }else{
                make.left.equalTo(toView.mas_right);
            }
            make.top.offset(0);
            make.bottom.offset(0);
            make.width.equalTo(self.mas_width);
        }];
        toView = vcContentView;
    }
    
    self.contentViews = viewArray;
    
    [scrollContentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(toView.mas_right);
    }];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.bottom.offset(0);
        make.left.offset(0);
        make.right.offset(0);
        make.right.equalTo(scrollContentView.mas_right);
    }];
    [self.scrollView setContentOffset:CGPointMake(320, 0)];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pagesViewDidScroll:)]) {
        [self.delegate pagesViewDidScroll:self];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat w = scrollView.contentSize.width/_contentViews.count;
    NSInteger sortingIndex = (scrollView.contentOffset.x)/w;
    NSInteger currIndex = [_contentSubView indexOfObject:[self.sortingArray objectAtIndex:sortingIndex]];
    
    [self setCurrIndex:currIndex];
    [self.scrollView setContentOffset:CGPointMake(w, 0)];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(pagesView:didSelectView:currIndex:)]) {
        [self.delegate pagesView:self didSelectView:_contentSubView[currIndex] currIndex:currIndex];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.delegate && [self.delegate respondsToSelector:@selector(pagesViewDidEndDragging:)]) {
        [self.delegate pagesViewDidEndDragging:self];
    }
}



- (CGPoint)contentOffset{
    
    CGFloat w = self.scrollView.contentSize.width/_contentViews.count;

    CGFloat offsetX = _currIndex*w+self.scrollView.contentOffset.x-w;
    if (offsetX>=self.scrollView.contentSize.width) {
        offsetX = offsetX - self.scrollView.contentSize.width;
    }
    if (offsetX < 0) {
        offsetX = self.scrollView.contentSize.width+offsetX;
    }
    
    _contentOffset = CGPointMake(offsetX, self.scrollView.contentOffset.y);
    return _contentOffset;
    
}

@end
