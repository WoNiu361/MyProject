//
//  YHShareInstance.h
//  MyProject
//
//  Created by LYH on 2019/9/19.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHShareInstance : NSObject

+ (instancetype)shareInstance;

/**
 切圆角
 
 @param viewFrame frame
 @param rectCorner UIRectCorner
 @param viewSize 圆角大小
 @return CAShapeLayer
 */
- (CAShapeLayer *)masksToBoundsWithFrame:(CGRect)viewFrame
                              rectCorner:(UIRectCorner)rectCorner
                                    size:(CGSize)viewSize;

/**
 获取当前时间
 
 @param formatter 时间类型 eg: yyyy-MM-dd HH:mm:ss
 @return 返回获取的当前时间
 */
- (NSString *)getCurrentTimeWithDateFormatter:(NSDateFormatter *)formatter;

/**
 改变文字的颜色
 
 @param color 要改变的文字颜色
 @param location 位置i
 @param lenth 长度
 @param text 文本
 @return 富文本
 */
- (NSMutableAttributedString *)changeColorWithColor:(UIColor *)color
                                           location:(NSInteger)location
                                              lenth:(NSInteger)lenth
                                               text:(NSString *)text;
#pragma mark - 改变文字的颜色和字体大小
- (NSMutableAttributedString *)changeColorAndFontWithColor:(UIColor *)color
                                                  location:(NSInteger)location
                                                     lenth:(NSInteger)lenth
                                                      text:(NSString *)text
                                                      font:(UIFont *)font;

/**
 判断字符串是否为空
 
 @param txt 字符串
 @return yes or  no
 */
- (BOOL)judgeStringWhetherBlank:(id)txt;

/**
 处理空的字符串
 
 @param str 字符串
 @return c处理过的字符串
 */
- (NSString *)dealWithEmptyStringWithStr:(NSString *)str;

/**
 比较俩个时间的大小
 @param oneDay     一个时间
 @param anotherDay 另一个时间
 @return  NSInteger类型
 */
- (NSInteger)compareOneDay:(NSString *)oneDay
                anotherDay:(NSString *)anotherDay
             dateFormatter:(NSString *)formatter;

/**
 照片获取本地路径转换
 
 @param Image     UIImage图片
 @return  图片转换成路径
 */
- (NSString *)getImagePath:(UIImage *)Image;

/**
 压缩图片
 
 @param image 被压缩的图片
 @return 返回data类型
 */
- (NSData *)compressImage:(UIImage *)image;

/// 生成一张渐变色的图片
/// @param colors 颜色数组
/// @param rect 图片大小
/// @return 渐变图片
- (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect;
@end

NS_ASSUME_NONNULL_END
