//
//  iSuperScrollElves.m
//  iSuperScrollElvesDemo
//
//  Created by 吴港 on 2017/5/23.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import "iSuperScrollElves.h"

@interface iSuperScrollElves ()<UIScrollViewDelegate>{
    
    NSInteger       _dataNumber;
    NSInteger       _cellNum;
    NSMutableArray *_cellArray;
    NSMutableArray *_cellSorting;
    
    UIScrollView   *_scrollView;
    
   __weak NSTimer        *_timer;
}
@end

@implementation iSuperScrollElves

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

- (void)loadUI{
    //滑动视图
    UIScrollView *baseScrollView = [[UIScrollView alloc] init];
//    baseScrollView.layer.masksToBounds = NO;
    _scrollView = baseScrollView;
    baseScrollView.showsHorizontalScrollIndicator = NO;
    baseScrollView.delegate = self;
    [self addSubview:baseScrollView];
}

- (void)reloadData{
    
    [self endT];
    
    for (UIView *cell in _cellArray) {
        [cell removeFromSuperview];
    }
    
    //准备数据
    _dataNumber = [self.dataSource numberIniSuperScrollElves];
    _cellNum = self.frame.size.width/(self.cellSize.width+self.cellSpacing)+3;
    _cellArray = [NSMutableArray arrayWithCapacity:_cellNum];
    _cellSorting = [NSMutableArray arrayWithCapacity:_dataNumber];
    
    _scrollView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _scrollView.contentSize = CGSizeMake((self.cellSize.width+self.cellSpacing)*_cellNum, self.frame.size.height);
    _scrollView.contentOffset = self.startOffset;
    if (_dataNumber==0) {
        return;
    }
    [self reloadCell];
    self.isAutomaticScroll = _isAutomaticScroll;
    
    if (self.isAutomaticScroll == YES) {
        [self startT];
    }
    
    
}

- (void)reloadCell{
    //开始创建cell (目前只假设cell只能是单数)
    for (int i = 0; i < _cellNum; i++) {
        
        //判断数据是否存在
        UIView *cell = nil;
        if (_cellArray.count < i+1) {
            if (i>_dataNumber-1) {
                cell = [self.dataSource iSuperScrollElves:self index:i%_dataNumber cell:nil];
                cell.tag = i%_dataNumber + 110;
            }else{
                cell = [self.dataSource iSuperScrollElves:self index:i cell:nil];
                cell.tag = i + 110;
            }
            
            
            [_cellArray addObject:cell];
            [_cellSorting addObject:@(i)];
            
            UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cellDid:)];
            [cell addGestureRecognizer:tapGesture];
            cell.userInteractionEnabled = YES;
            
        }else{
            cell = _cellArray[i];
        }
        
        
        cell.frame = CGRectMake(i*(self.cellSize.width+self.cellSpacing), self.frame.size.height/2-_cellSize.height/2, _cellSize.width, _cellSize.height);
        [_scrollView addSubview:cell];
    }
}

- (void)cellDid:(UITapGestureRecognizer *)rec{
    if (self.delegate && [self.delegate respondsToSelector:@selector(iSuperScrollElves:didSelectItemAtIndex:cell:)]) {
        [self.delegate iSuperScrollElves:self didSelectItemAtIndex:rec.view.tag-110 cell:rec.view];
    }
}

//滑动视图代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //向前划还是向后划
    NSInteger forwardNum = 3;
    CGPoint offset = scrollView.contentOffset;
    if (offset.x>=(_cellSize.width+self.cellSpacing)*2) {
        offset.x = (_cellSize.width+self.cellSpacing);
        forwardNum = 1;
    }
    else if (offset.x <= 0){
        offset.x = (_cellSize.width+self.cellSpacing);
        forwardNum = 0;
    }
    scrollView.contentOffset = offset;
    
    //每次切换 重新布局view
    if (forwardNum == 1) {
        //前进
        [_cellSorting removeObjectAtIndex:0];
        NSInteger oIndex = [_cellSorting.lastObject integerValue] + 1;
        
        NSInteger newIndex = oIndex>(_dataNumber-1)?0:oIndex;
        [_cellSorting addObject:@(newIndex)];
        
        UIView *cell = _cellArray[0];
        [_cellArray removeObjectAtIndex:0];
        UIView *newCell = [self.dataSource iSuperScrollElves:self index:newIndex cell:cell];
        if (newCell == nil) {
            NSLog(@"___%@",self);
            NSLog(@"发生异常！");
            return;
        }
        [_cellArray addObject:newCell];
        
        //重新调整控件位置
        [self reloadCell];
        
    }else if (forwardNum == 0){
        //后退
        [_cellSorting removeLastObject];
        NSInteger oIndex = [_cellSorting[0] integerValue] - 1;
        
        NSInteger newIndex = oIndex<0?_dataNumber-1:oIndex;
        
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@(newIndex), nil];
        [array addObjectsFromArray:_cellSorting];
        _cellSorting = array;
        
        
        //取出即将被复用的Cell
        UIView *cell = _cellArray.lastObject;
        //从原数组中调整位置
        [_cellArray removeLastObject];
        
        UIView *newCell = [self.dataSource iSuperScrollElves:self index:newIndex cell:cell];
        
        //将新View加到第一位
        NSMutableArray *newViewArray = [NSMutableArray arrayWithObjects:newCell, nil];
        [newViewArray addObjectsFromArray:_cellArray];
        _cellArray = newViewArray;
        //重新调整控件位置
        [self reloadCell];
    }
    
}

- (void)setIsAutomaticScroll:(BOOL)isAutomaticScroll{
    _isAutomaticScroll = isAutomaticScroll;
    if (_cellNum==0) {
        return;
    }
    if (_isAutomaticScroll) {
        [self startT];
    }else{
        [self endT];
    }
}

- (void)startT{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(viewMove) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}

- (void)endT{
    [_timer invalidate];
    _timer = nil;
}

- (void)viewMove{
    
    //定时器运行中会导致本类无法正常释放 当检测到数据源为空时应停止定时器 以防出现异常情况
    if (self.dataSource == nil) {
        [self endT];
        return;
    }
    
    __block CGPoint offset = _scrollView.contentOffset;
    
    offset = CGPointMake(offset.x+0.5, 0);
    [_scrollView setContentOffset:offset animated:NO];
}


@end
