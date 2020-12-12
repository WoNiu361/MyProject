//
//  UIImage+YHImage.h
//  MyProject
//
//  Created by 吕颜辉 on 2020/9/9.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YHImage)

/// 根据颜色生成一张图片
/// @param color 颜色
/// @param size 图片尺寸大小
/// @param alpha 透明度 0~1
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;

/// 根据颜色生成一张图片
/// @param size 图片尺寸大小
/// @param color 颜色
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/// 生成一张渐变色的图片
/// @param colors 颜色数组
/// @param rect 图片大小
/// @return 渐变图片
+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect;

+ (UIImage *)gradientGlobalImageWithrect:(CGRect)rect;


/**
 根据颜色生成 1x1 point 图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;


/**
 *  根据UIColor和cornerRadius生成圆角的UIImage
 *
 *  @param color 生成图片的颜色
 *  @param cornerRadius 圆角的半径
 *  @return 生成的UIImage对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius;


/**
 根据UIColor和cornerRadius生成带边框及圆角的UIImage

 @param color 生成图片的颜色
 @param cornerRadius 圆角的半径
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 生成的UIImage对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius
                borderWidth:(CGFloat)borderWidth
                borderColor:(UIColor *)borderColor;

/**
 根据颜色生成带圆角、边框的图片
 
 @param color 颜色
 @param cornerRadius 圆角半径
 @param borderWidth 圆角边框
 @param borderColor 边框颜色
 @param borderLineJoin 线条交叉类型
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
                borderWidth:(CGFloat)borderWidth
                borderColor:(UIColor *)borderColor
             borderLineJoin:(CGLineJoin)borderLineJoin;

/**
 *  生成返回按钮图片
 *
 *  @param color        按钮颜色
 *  @param metrics      尺寸类型
 *  @param cornerRadius 圆角度数
 *
 *  @return 生成的UIImage对象
 */
+ (UIImage *)backButtonImageWithColor:(UIColor *)color
                           barMetrics:(UIBarMetrics)metrics
                         cornerRadius:(CGFloat)cornerRadius;

/**
 生成带边框的圆形图
 
 @param image 要裁剪的图片
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 带边框的圆形图
 */
+ (UIImage *)circleImageWithImage:(UIImage *)image
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor;


/**
 生成带圆环边框的image
 
 @param name imageName
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return image
 */
+ (UIImage *)circleImageWithName:(NSString *)name
                     borderWidth:(CGFloat)borderWidth
                     borderColor:(UIColor *)borderColor;

/**
 根据文字生成标签
 
 @param str 文字
 @param BgColor 背景颜色
 @param font 字体大小
 @param textColor 文字颜色
 @param bgImage 背景图片
 @param corner 圆角
 @return image
 */
+ (UIImage *)createFlagIamgeWithStr:(NSString *)str withBgColor:(UIColor *)BgColor image:(UIImage *)bgImage withFont:(UIFont *)font withTextColor:(UIColor *)textColor corner:(CGFloat)corner;

/**
 生成带文字的图片
 
 @param str 文字
 @param image 图片
 @param fontSize 文字字号
 @param textColor 文字颜色
 @return 画好的图片
 */
+ (UIImage *)createOtherMerchantImageWithStr:(NSString *)str
                                 withBgImage:(UIImage *)image
                                    withFont:(CGFloat)fontSize
                               withTextColor:(UIColor *)textColor;

/**
 *  截图
 *  @param view 需要截的View
 *  @return 截图
 */
+ (UIImage *)captureWithView:(UIView *)view;

/**
 *  获取屏幕截图
 *  @return 屏幕截图
 */
+ (UIImage *)screenshots;


/**
 *  生成毛玻璃效果的图片
 *
 *  @return 生成的UIImage对象
 */
- (UIImage *)imageWithBlur;


/**
 *  生成自定义毛玻璃效果的图片
 *
 *  @param alpha                 透明度 0~1，0为白，1为深灰色
 *  @param radius                半径:默认30, 推荐值 3  半径值越大越模糊, 值越小越清楚
 *  @param colorSaturationFactor 色彩饱和度(浓度)因子：0是黑白灰，9是浓彩色，1是原色 默认1.8； “彩度”，英文是称Saturation，即饱和度。将无彩色的黑白灰定为0，最鲜艳定为9s，这样大致分成十阶段，让数值和人的感官直觉一致。
 *
 *  @return 生成的UIImage对象
 */
- (UIImage *)imageWithalpha:(CGFloat)alpha
                     radius:(CGFloat)radius
      colorSaturationFactor:(CGFloat)colorSaturationFactor;



/**
 *  根据maxImagePix设定的图片最大显示像素压缩图片
 *
 *  @param maxImagePix
 *  最大一边图片像素，如宽高为600px*500px的图片
 *  压缩为最长一边为400px
 *  压缩后的图片尺寸为 400px*333px
 *
 *  @return 压缩生成的UIImage对象
 */
- (UIImage *)compressedImage:(float)maxImagePix;



/**
 压缩至指定字节的图片

 @param maxLength 指定字节
 @return 压缩生成的UIImage对象
 */
- (NSData *)compressedDataWithMaxLengh:(NSInteger)maxLength;


/**
 *  根据图片数组生成从左往右的图片重叠合成图
 *
 *  @param size 生成图大小
 *
 *  @param array 图片数组
 *
 *  @return 重绘生成的UIImage对象
 */
+ (UIImage *)overlapImageWithSize:(CGSize)size
                       imageArray:(NSArray *)array;


/**
 生成二维码【白底黑色】

 @param content 二维码内容字符串【数字、字符、链接等】
 @param size 生成图片的大小
 @return UIImage图片对象
 */
+ (UIImage*)createQRImageWithString:(NSString*)content QRSize:(CGSize)size;


/**
 生成二维码【自定义颜色】

 @param content 二维码内容字符串【数字、字符、链接等】
 @param size 生成图片的大小
 @param qrColor 二维码颜色
 @param bkColor 背景色
 @return UIImage图片对象
 */
+ (UIImage* )createQRImageWithString:(NSString*)content QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor;


/**
 生成条形码【白底黑色】

 @param content 条码内容【一般是数字】
 @param size 生成条码图片的大小
 @return UIImage图片对象
 */
+ (UIImage *)createBarCodeImageWithString:(NSString *)content barSize:(CGSize)size;


/**
 生成条形码【自定义颜色】

 @param content 条码内容【一般是数字】
 @param size 生成条码图片的大小
 @param qrColor 码颜色
 @param bkColor 背景颜色
 @return UIImage图片对象
 */
+ (UIImage* )createBarCodeImageWithString:(NSString*)content QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor;

@end

NS_ASSUME_NONNULL_END
