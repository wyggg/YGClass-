//
//  NSString+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 16/8/16.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import "NSString+YGTool.h"
#import "NSObject+YGTool.h"

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import <CommonCrypto/CommonCryptor.h>

@implementation NSString (YGTool)

///转换成url
- (NSURL *)URL{
    return [NSURL URLWithString:self];
}

///生成图片
- (UIImage *)image{
    if (![NSString isStringThereAre:self]) {
        return nil;
    }
    return [UIImage imageNamed:self];
}

///转换成data UTF-8
- (NSData *)dataUTF8{
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

///Base64编码
- (NSString *)base64Encode{
    if (![NSString isStringThereAre:self]) {
        return nil;
    }
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

///Base64解码
- (NSString *)base64Decode{
    if (![NSString isStringThereAre:self]) {
        return nil;
    }
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

///MD5加密
- (NSString *)md5String{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (uint32_t)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]
            ];
}


///是否为空
+ (BOOL)isStringThereAre:(NSString *)string{
    if (string==nil) {
        return NO;
    }
    if (string.length==0) {
        return NO;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return NO;
    }
    return YES;
}

///textfile只能输入价格
+ (BOOL)validateNumber:(NSString*)number text:(NSString *)textFieldText floatCount:(NSInteger)floatCount {
    
    BOOL res = YES;
    
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    
    int i = 0;
    
    if (number.length==0) {
        
        //允许删除
        return YES;
    }
    
    while (i < number.length) {
        
        //确保是数字
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    
    if (textFieldText.length==0) {
        
        //第一个不能是
        if ([number isEqualToString:@"."]) {
            return NO;
        }
    }
    
    NSArray *array = [textFieldText componentsSeparatedByString:@"."];
    NSInteger count = [array count] ;
    
    //小数点只能有一个
    if (count>1&&[number isEqualToString:@"."]) {
        return NO;
    }
    
    //控制小数点后面的字数
    if ([textFieldText rangeOfString:@"."].location!=NSNotFound) {
        if (textFieldText.length-[textFieldText rangeOfString:@"."].location>floatCount) {
            return NO;
        }
    }
    return res;
}


///是否全部是空格
- (BOOL)isAllWhiteSpace{
    if (![NSString isStringThereAre:self]) {
        return nil;
    }
    
    NSString *trimString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (trimString.length > 0) {
        return NO;
    }else{
        return YES;
    }
}

//是否符合正则条件
- (BOOL)regexMatch:(NSString *)regexString{
    if (![NSString isStringThereAre:self]) {
        return nil;
    }
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    return [emailTest evaluateWithObject:self];
}

///只包含数字和字母
- (BOOL)isOnlyNumAndLetter{
    NSString *regex = @"[a-z][A-Z][0-9]";
    return [self regexMatch:regex];
}

///是否是邮箱
- (BOOL)isEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self regexMatch:emailRegex];
}

///是否是手机号
- (BOOL)isPhone{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    return [self regexMatch:phoneRegex];
}

///是否是Url
- (BOOL)isUrl{
    NSString *checkRegex = @"^(([hH][tT]{2}[pP][sS]?)|([fF][tT][pP]))\\:\\/\\/[wW]{3}\\.[\\w-]+\\.\\w{2,4}(\\/.*)?$";
    return [self regexMatch:checkRegex];
}

///是否是邮政编码
-  (BOOL)isMailCode{
    NSString *mailCodeRegex = @"^\\d{6}$";
    return [self regexMatch:mailCodeRegex];
}

///是否是身份证号
- (BOOL)isIdCard{
    NSString *regexIdCard = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [self regexMatch:regexIdCard];
}

///是否是身份证号（严格）
- (BOOL)isIdCardFormStrict{
    
    BOOL isIdCard = NO;
    if (self.length==15) {
        NSString * identifyTest=@"^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$";
        isIdCard = [self regexMatch:identifyTest];
    }else if (self.length==18){
        NSString * identifyTest=@"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
        isIdCard = [self regexMatch:identifyTest];
    }
    return isIdCard;
    
}

///是否是车牌号
- (BOOL)isCarNumber{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    return [self regexMatch:carRegex];
}

///返回隐藏手机号中4位的字符串
- (NSString*)getSecrectPhoneString{
    if (![self isPhone]) {
        NSLog(@"不是手机号");
        return @"";
    }
    
    NSMutableString *newStr = [NSMutableString stringWithString:self];
    NSRange range = NSMakeRange(3, 4);
    [newStr replaceCharactersInRange:range withString:@"****"];
    return newStr;
}

///是否是银行卡号
- (BOOL)isBankCardNumber{
    NSString *bankCardNumber = @"^(\\d{16}|\\d{19})$";
    return [self regexMatch:bankCardNumber];
}

//返回隐藏银行卡号中8位的字符串
- (NSString *)getSecrectBankCardNumberString
{
    if (![self isBankCardNumber]) {
        NSLog(@"不是银行卡号");
        return @"";
    }
    NSMutableString *newStr = [NSMutableString stringWithString:self];
    NSRange range = NSMakeRange(4, 8);
    if (newStr.length>12) {
        [newStr replaceCharactersInRange:range withString:@" **** **** "];
    }
    return newStr;
}

//string中是否存在Emoji表情
- (BOOL)isContainsEmoji{
    
    if (![NSString isStringThereAre:self]) {
        return NO;
    }
    
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    return returnValue;
}

//过滤表情
- (NSString *)removeAllEmiji{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}


///计算字符串size
- (CGSize)textSize:(CGSize)size fontSize:(CGFloat)fontSize{
    if (![NSString isStringThereAre:self]) {
        return CGSizeMake(0, 0);
    }
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize  actualsize =[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin  attributes:dic context:nil].size;
    return actualsize;
}

///过滤全部空格
- (NSString *)removeAllSpace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

@end

///富文本工具类
@implementation NSString (HTMLTool)

NSString *const HTMLTool_cssCodePhoneA = @".duanluo{font-size:15px;color:#333333;text-align:left;margin:10px;}img{width: 100%;height: auto;}";

///为HTML字符片段添加css布局代码
- (NSString *)addCSSCode:(NSString *)cssCode title:(NSString *)title charset:(NSString *)charset{
    
    charset = charset.length==0?@"UTF-8":charset;
    
    return [NSString stringWithFormat:@"<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"%@\"><title>%@</title><link rel=\"stylesheet\" href=\"mui.min.css\"><style>%@</style></head><body>%@</body></html>",charset,title,cssCode,self];
}

@end


@implementation NSNull (nullString)

///非空判断
- (BOOL)isNullString{
    return YES;
}

- (NSURL *)URL{
    NSLog(@"NSNull调用 URL 方法");
    return nil;
}
- (UIImage *)image{
    NSLog(@"NSNull调用 image 方法");
    return nil;
}
- (NSString *)formatString{
    NSLog(@"NSNull调用 formatString 方法");
    return @"";
}
- (NSData *)dataUTF8{
    NSLog(@"NSNull调用 dataUTF8 方法");
    return nil;
}

- (NSUInteger)length{
    NSLog(@"NSNull调用 length 方法");
    return 0;
}

- rangeOfCharacterFromSet:(id)a{
    NSLog(@"NSNull调用 rangeOfCharacterFromSet 方法");
    return nil;
}

- hasColorGlyphsInRange:(id)a attributes:(id)b{
    NSLog(@"NSNull调用 hasColorGlyphsInRange 方法");
    return nil;
}

- (BOOL)isEqualToString:(NSString *)str{
    return [@"" isEqualToString:str];
}
@end
