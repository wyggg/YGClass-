//
//  NSString+YGTool.h
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/16.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (YGTool)

#pragma mark - 转换
@property (nonatomic, weak, readonly) NSURL *URL;
@property (nonatomic, weak, readonly) UIImage *image;
@property (nonatomic, weak, readonly) NSData *dataUTF8;

#pragma mark - 加密
@property (nonatomic, weak, readonly) NSString *base64Encode;
@property (nonatomic, weak, readonly) NSString *base64Decode;
@property (nonatomic, weak, readonly) NSString *md5String;

#pragma mark - 正则

///控制只能输入价格
+ (BOOL)validateNumber:(NSString*)number text:(NSString *)textFieldText floatCount:(NSInteger)floatCount;

///是否存在（不为Null）
+ (BOOL)isStringThereAre:(NSString *)string;

///是否全部是空格
- (BOOL)isAllWhiteSpace;

///过滤全部空格
- (NSString *)removeAllSpace;


///使用正则判断字符串
- (BOOL)regexMatch:(NSString *)regexString;

///只包含数字和字母是否
- (BOOL)isOnlyNumAndLetter;

///是否是邮箱
- (BOOL)isEmail;

///是否是手机号
- (BOOL)isPhone;

///电话号码中间4位****显示
- (NSString*)getSecrectPhoneString;

///是否是银行卡号
- (BOOL)isBankCardNumber;

///银行卡号中间8位****显示
- (NSString*)getSecrectBankCardNumberString;

///是否是URL
- (BOOL)isUrl;

///是否是邮政编码
- (BOOL)isMailCode;

///是否是身份证号
- (BOOL)isIdCard;

///是否是身份证号（严格）
- (BOOL)isIdCardFormStrict;

///是否是车牌号
- (BOOL)isCarNumber;

///是否包含Emoji表情
- (BOOL)isContainsEmoji;

///过滤字符串中包含的Emoji表情
- (NSString *)removeAllEmiji;


#pragma mark - size

///计算字符串 Size
- (CGSize)textSize:(CGSize)size
          fontSize:(CGFloat)fontSize;

@end

///富文本工具类
@interface NSString (HTMLTool)

///适合手机端的布局A 图文展示
extern NSString *const HTMLTool_cssCodePhoneA;

///为HTML字符片段添加css布局代码 cssCode:布局代码  title：标题   charset：字符集 （传空默认 UTF-8）
- (NSString *)addCSSCode:(NSString *)cssCode title:(NSString *)title charset:(NSString *)charset;


@end

//空对象安全处理
@interface NSNull (nullString)

///非空判断
- (BOOL)isNullString;
@property (nonatomic, weak, readonly) NSURL *URL;
@property (nonatomic, weak, readonly) UIImage *image;
@property (nonatomic, weak, readonly) NSData *dataUTF8;

//系统常用
@property (readonly) NSUInteger length;
- rangeOfCharacterFromSet:(id)a;
- hasColorGlyphsInRange:(id)a attributes:(id)b;
- (BOOL)isEqualToString:(NSString *)str;

@end
