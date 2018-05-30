//
//  YGPlayModel.h
//  Operator
//
//  Created by yg on 2018/1/10.
//  Copyright © 2018年 北京内圈科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

//播放类型
typedef NS_ENUM(NSInteger, YGPlayType) {
    YGPlayType_Mp3URL = 0,
};

@interface YGPlayModel : NSObject

@property (nonatomic, assign) YGPlayType playType;
@property (nonatomic, assign) NSString *mediaSource;

@end
