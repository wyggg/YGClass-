//
//  iSuperScrollElves.h
//  iSuperScrollElvesDemo
//
//  Created by 吴港 on 2017/5/23.
//  Copyright © 2017年 吴港. All rights reserved.
//

#import <UIKit/UIKit.h>
@class iSuperScrollElves;

@protocol iSuperScrollElvesDataSource <NSObject>

- (NSInteger)numberIniSuperScrollElves;
- (UIView *)iSuperScrollElves:(iSuperScrollElves *)elves index:(NSInteger)index cell:(UIView *)cell;

@end

@protocol iSuperScrollElvesDelegate <NSObject>

@optional
- (void)iSuperScrollElves:(iSuperScrollElves *)elves didSelectItemAtIndex:(NSInteger)index cell:(UIView *)cell;

@end

///复用的无限滚动视图
@interface iSuperScrollElves : UIView

@property (nonatomic, weak) id <iSuperScrollElvesDataSource>dataSource;
@property (nonatomic, weak) id <iSuperScrollElvesDelegate>delegate;

@property (nonatomic, assign) CGSize cellSize;
@property (nonatomic, assign) CGFloat cellSpacing;
@property (nonatomic, assign) CGPoint startOffset;

//释放时请先关闭定时器 否则可能导致无法释放
@property (nonatomic, assign) BOOL isAutomaticScroll;


- (void)reloadData;

@end
