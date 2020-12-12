//
//  NSString+YHString.m
//  MyProject
//
//  Created by 吕颜辉 on 2018/6/22.
//  Copyright © 2018 LYH-1140663172. All rights reserved.
//

#import "NSString+YHString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (YHString)

/**
 计算字符串长度 中文两个字节 英文一个字节
 @return 字体长度
 */
- (NSInteger)unicodeStrlength{
    
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData* data = [self dataUsingEncoding:enc];
    return [data length];
}

/**
 计算字符串长度
 @param font 字体大小
 @param maxSize 最大尺寸
 @return 字符串尺寸
 */
- (CGSize)sizehWithFont:(UIFont *)font maxSize:(CGSize)maxSize
{
    return [self sizehWithFont:font lineSpacing:0.0 maxSize:maxSize];
}

/**
 计算字符串高度

 @param font 文字大小
 @param lineSpacing 行高
 @param maxSize 最大尺寸
 @return 文字行高
 */
- (CGSize)sizehWithFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing maxSize:(CGSize)maxSize {
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    if (lineSpacing>0) {
        paraStyle.lineSpacing = lineSpacing;
    }
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *dic = @{
                          NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle
                          };
    CGSize size = [self boundingRectWithSize:maxSize options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return  size;
}

-(NSString *)md5
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0],result[1],result[2],result[3],result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],result[12],result[13],result[14],result[15]
            ];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"

//常见警告的名称
//1, 声明变量未使用  "-Wunused-variable"
//2, 方法定义未实现  "-Wincomplete-implementation"
//3, 未声明的选择器  "-Wundeclared-selector"
//4, 参数格式不匹配  "-Wformat"
//5, 废弃掉的方法    "-Wdeprecated-declarations"
//6, 不会执行的代码  "-Wunreachable-code"
//7，不能传nil值    "-Wnonnull"//不能传nil”

- (NSString *)urlEncode
{
    if ([self respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)]) {
        /**
         AFNetworking/AFURLRequestSerialization.m
         
         Returns a percent-escaped string following RFC 3986 for a query string key or value.
         RFC 3986 states that the following characters are "reserved" characters.
         - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
         - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
         In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
         query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
         should be percent-escaped in the query string.
         - parameter string: The string to be percent-escaped.
         - returns: The percent-escaped string.
         */
        static NSString * const kAFCharactersGeneralDelimitersToEncode = @":#[]@"; // does not include "?" or "/" due to RFC 3986 - Section 3.4
        static NSString * const kAFCharactersSubDelimitersToEncode = @"!$&'()*+,;=";
        
        NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
        [allowedCharacterSet removeCharactersInString:[kAFCharactersGeneralDelimitersToEncode stringByAppendingString:kAFCharactersSubDelimitersToEncode]];
        static NSUInteger const batchSize = 50;
        
        NSUInteger index = 0;
        NSMutableString *escaped = @"".mutableCopy;
        
        while (index < self.length) {
            NSUInteger length = MIN(self.length - index, batchSize);
            NSRange range = NSMakeRange(index, length);
            // To avoid breaking up character sequences such as 👴🏻👮🏽
            range = [self rangeOfComposedCharacterSequencesForRange:range];
            NSString *substring = [self substringWithRange:range];
            NSString *encoded = [substring stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
            [escaped appendString:encoded];
            
            index += range.length;
        }
        return escaped;
    } else {
        
        CFStringEncoding cfEncoding = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *encoded = (__bridge_transfer NSString *)
        CFURLCreateStringByAddingPercentEscapes(
                                                kCFAllocatorDefault,
                                                (__bridge CFStringRef)self,
                                                NULL,
                                                CFSTR("!#$&'()*+,/:;=?@[]"),
                                                cfEncoding);
        return encoded;
        
    }
}

- (NSString *)urlDecode
{
    if ([self respondsToSelector:@selector(stringByRemovingPercentEncoding)]) {
        return [self stringByRemovingPercentEncoding];
    } else {
        
        CFStringEncoding en = CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding);
        NSString *decoded = [self stringByReplacingOccurrencesOfString:@"+"
                                                            withString:@" "];
        decoded = (__bridge_transfer NSString *)
        CFURLCreateStringByReplacingPercentEscapesUsingEncoding(
                                                                NULL,
                                                                (__bridge CFStringRef)decoded,
                                                                CFSTR(""),
                                                                en);
        return decoded;
        
    }
}


+ (NSString *)getUploadImageKeyWithType:(NSString *)imageType{
    
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss:SSS"];
    NSString *timeStr = [dateFormatter stringFromDate:[NSDate date]];
    NSString *keyName = [[uuid stringByAppendingString:timeStr] md5];
    return [NSString stringWithFormat:@"%@.%@",keyName,imageType];
}

#pragma clang diagnostic pop

@end
