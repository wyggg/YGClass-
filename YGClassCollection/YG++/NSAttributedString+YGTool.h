//
//  NSAttributedString+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/13.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSAttributedString (YGTool)

//计算富文本高度
- (CGFloat)heightWithContainWidth:(CGFloat)width;

@end
