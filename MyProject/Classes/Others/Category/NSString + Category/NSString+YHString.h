//
//  NSString+YHString.h
//  MyProject
//
//  Created by 吕颜辉 on 2018/6/22.
//  Copyright © 2018 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (YHString)

/**
 计算字符串长度 中文两个字节 英文一个字节
 @return 字体长度
 */
- (NSInteger)unicodeStrlength;

/**
 计算字符串长度
 @param font 字体大小
 @param maxSize 最大尺寸
 @return 字符串尺寸
 */
- (CGSize)sizehWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 计算字符串高度

 @param font 文字大小
 @param lineSpacing 行高
 @param maxSize 最大尺寸
 @return 文字尺寸
 */
- (CGSize)sizehWithFont:(UIFont*)font lineSpacing:(CGFloat)lineSpacing maxSize:(CGSize)maxSize;
/**
 生成md5字符串
 */
-(NSString *)md5;

/**
 URLEncode
 */
- (NSString *)urlEncode;

/**
 URLDecode
 */
- (NSString *)urlDecode;

/**
生成传图片名称

@param imageType jpg、gif
@return 图片名称
*/

+ (NSString *)getUploadImageKeyWithType:(NSString *)imageType;

@end

NS_ASSUME_NONNULL_END
