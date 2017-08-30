//
//  YGImageModel.h
//  高薪工资
//
//  Created by yg on 2017/8/14.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface YGImageModel : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *index;

+ (id)modelInImage:(UIImage *)image index:(NSInteger)index;
+ (NSArray *)modelInImages:(NSArray <UIImage *>*)image startIndex:(NSInteger)startIndex;

@end
