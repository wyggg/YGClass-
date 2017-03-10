//
//  YGObjectModel.m
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/7.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import "YGObjectModel.h"
#import "YGClassCollection.h"

@implementation YGObjectModel

LOGALL_DIC

+ (NSDictionary *)propertieClassInDictionary{
    return @{@"hahaha":[YGObjectModelTow class],
             @"name":[YGObjectModelTow class]};
}

///替换关键属性名 如 id替换为ID
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

@end
