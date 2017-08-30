//
//  YGImageModel.m
//  高薪工资
//
//  Created by yg on 2017/8/14.
//  Copyright © 2017年 上玄科技. All rights reserved.
//

#import "YGImageModel.h"

@implementation YGImageModel

+ (id)modelInImage:(UIImage *)image index:(NSInteger)index{
    
    YGImageModel *model = [[YGImageModel alloc] init];
    model.image = image;
    model.index = [NSString stringWithFormat:@"%.0f",(double)index];
    return model;
}

+ (NSArray *)modelInImages:(NSArray <UIImage *>*)image startIndex:(NSInteger)startIndex{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < image.count; i++) {
        YGImageModel *model = [YGImageModel modelInImage:image[i] index:startIndex+i];
        [array addObject:model];
    }
    
    return array;
    
}

@end
