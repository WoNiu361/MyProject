//
//  UIColor+YHColor.m
//  MyProject
//
//  Created by LYH on 2019/9/19.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "UIColor+YHColor.h"

@implementation UIColor (YHColor)

static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    str = [[str stringByTrimmingCharactersInSet:set] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}


+ (UIColor *)colorWithHex:(long)hexColor {
    
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0f;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0f;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF))/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha{
    
    CGFloat red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0f;
    CGFloat green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0f;
    CGFloat blue = ((CGFloat)(hexColor & 0xFF))/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark 将16进制色值代码转换为UIColor对象
+ (UIColor *)colorFromHexCode:(NSString *)hexString
{
    CGFloat r, g, b, a;
    if (hexStrToRGBA(hexString, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
    
}

@end
