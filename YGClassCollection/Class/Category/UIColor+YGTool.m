//
//  UIColor+YGTool.m
//  YGClassCollection
//
//  Created by iOS wugang on 16/9/5.
//  Copyright © 2016年 吴港. All rights reserved.
//

#import "UIColor+YGTool.h"

@implementation UIColor (YGTool)

//随机色
+ (UIColor *)randomColor{
    CGFloat hue = (arc4random()%256/256.0);
    CGFloat saturation = (arc4random()%128/256.0)+0.5;
    CGFloat brightness = (arc4random()%128/256.0)+0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

+ (UIColor *)colorWithImageTheme:(UIImage *)image{
    return [UIColor colorWithImageTheme:image imageSize:CGSizeMake(20, 20)];
}

+ (UIColor *)colorWithImageTheme:(UIImage *)image imageSize:(CGSize)size{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,size.width,size.height,8,size.width*4,colorSpace,bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, size.width, size.height);
    CGContextDrawImage(context, drawRect, image.CGImage);
    CGColorSpaceRelease(colorSpace);
    
    //取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    
    if (data == NULL){
        CGContextRelease(context);
        return nil;
    }
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:size.width*size.height];
    
    for (int x=0; x<size.width; x++) {
        for (int y=0; y<size.height; y++) {
            
            int offset = 4*(x*y);
            
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];
            
        }
    }
    CGContextRelease(context);
    //找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f)
                           green:([MaxColor[1] intValue]/255.0f)
                            blue:([MaxColor[2] intValue]/255.0f)
                           alpha:([MaxColor[3] intValue]/255.0f)];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)colorWithHexString:(NSString *)color
{
    return [self colorWithHexString:color alpha:1.0f];
}

//修改透明度
- (UIColor *)transparentColor:(CGFloat)transparent{
    NSDictionary *rgbs = [self colorRGB];
    return [UIColor colorWithRed:[rgbs[@"R"] floatValue]
                           green:[rgbs[@"G"] floatValue]
                            blue:[rgbs[@"B"] floatValue] alpha:transparent];
}

//获得颜色RGB的值
- (NSDictionary *)colorRGB{
    
    CGFloat components[3];
    
    CGColorSpaceRef rgbColorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char resultingPixel[4];
    CGContextRef context = CGBitmapContextCreate(&resultingPixel,1,1,8,4,rgbColorSpace,(CGBitmapInfo)kCGImageAlphaNoneSkipLast);
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, 1, 1));
    CGContextRelease(context);
    CGColorSpaceRelease(rgbColorSpace);
    for (int component = 0; component < 3; component++) {
        components[component] = resultingPixel[component] / 255.0f;
    }
    
    return @{@"R":@(components[0]),
             @"G":@(components[1]),
             @"B":@(components[2])};
}

@end
