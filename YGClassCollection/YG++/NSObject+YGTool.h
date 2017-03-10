//
//  NSObject+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/16.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YGTool)

#pragma mark - Array
///根据数组内对象某个key的值 将数组内数据进行分类 @[@[obj],@[obj]]
- (NSArray *)classificationWithKey:(NSString *)key;

#pragma mark - 判断类
///对象是否为空
- (BOOL)isNullObject;
///获得包含所有基础类的数组
+ (NSArray *)foundationClasses;
///判断本类是否为基础类 NSString、NSNumber等...
+ (BOOL)isClassFormFoundationClasses;
- (BOOL)isClassFormFoundationClasses;

#pragma mark - 数据解析

///过滤空值
- (id)removeAllNull;
///过滤字典在中所有的空值
- (NSDictionary *)removeAllNullInDic;
///过滤数组中所有的空值
- (NSArray <id>*)removeAllNullInArray;

///获得所有属性名称
- (NSArray <NSString *>*)allProperties;
+ (NSArray <NSString *>*)allProperties;

///获得所有属性名称和值
- (NSDictionary *)allPropertiesAndValue;

///类型转换
- (id)jsonObject;
- (NSData *)jsonData;
- (NSString *)jsonString;

///对数据进行安全处理返回为字符串 可防止使用到NSNull而发生崩溃的情况
- (NSString *)formatString;

///对象转模型
+ (id)parsingObj:(id)obj;
+ (instancetype)modelWithObjectDictionary:(NSDictionary *)objectDictionary;
+ (NSArray *)modelWithObjectArray:(NSArray *)objectArray;

///模型转对象
- (id)objValues;
- (NSDictionary *)dicValues;
- (NSArray *)aryValues;

///表明某个属性对应的class  return @{@"user":[Model class]};
+ (NSDictionary *)propertieClassInDictionary;
///替换关键属性名   return @{@"ID":@"id"};
+ (NSDictionary *)replacedKeyFromPropertyName;

#pragma mark - 数据持久化
+ (instancetype)modelDataInFileName:(NSString *)fileName;
- (BOOL)saveValuesInFileName:(NSString *)fileName;
+ (void)removeObjInFileName:(NSString *)fileName;


#pragma mark - 宏定义
/*
 以下宏写在model的.m文件中
 */

//打印全部 输出为json字符串
#define LOGALL_JSON \
- (NSString *)description{\
    return [[self objValues] jsonString];\
}

//打印全部 输出为字典
#define LOGALL_DIC \
- (NSString *)description{\
    return [[self objValues] formatString];\
}

@end
