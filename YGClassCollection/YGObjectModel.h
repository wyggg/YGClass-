//
//  YGObjectModel.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/7.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGObjectModelTow.h"
#import <UIKit/UIKit.h>

///演示model
@interface YGObjectModel : NSObject

@property (nonatomic, strong) NSArray <YGObjectModelTow *>*name;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) YGObjectModelTow *hahaha;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) UIColor *color;

@end
