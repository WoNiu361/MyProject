//
//  UITextField+THTextField.h
//  TH-ChiefApp
//
//  Created by 吕颜辉 on 2017/5/5.
//  Copyright © 2017年 吕颜辉-1140663172@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (THTextField)
/**
设置不带边框自定义颜色的TextField

@param frame 尺寸大小
@param color 字体颜色
@param textFont 字体大小
@param weight 字体权重
@param textAlignment 字体的位置
@param placeholder 占位文字
@return TextField
*/
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                          textcolor:(UIColor *)color
                           textFont:(CGFloat)textFont
                      textAlignment:(NSTextAlignment)textAlignment
                        placeholder:(NSString *)placeholder
                         textWeight:(UIFontWeight)weight;

/**
 设置带边框自定义颜色的TextField

 @param frame 尺寸大小
 @param textColor 字体颜色
 @param textFont 字体大小
 @param weight 字体权重
 @param textAlignment 字体的位置
 @param placeholder 占位文字
 @param borderColor 边框的颜色
 @param borderWidth 边框的宽度
 @return TextField
 */
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                          textcolor:(UIColor *)textColor
                           textFont:(CGFloat)textFont
                      textAlignment:(NSTextAlignment)textAlignment
                        placeholder:(NSString *)placeholder
                         textWeight:(UIFontWeight)weight
                        borderColor:(UIColor *)borderColor
                         borderWith:(CGFloat)borderWidth
                       cornerRadius:(CGFloat)cornerRadius;

/// 设置占位文字的颜色和字体大小
/// @param placeholder 占位文字
/// @param placeholderFont 占位文字字体大小
/// @param placeholderColor 占位文字颜色
- (void)setPlaceholder:(NSString *)placeholder
       placeholderFont:(UIFont *)placeholderFont
      placeholderColor:(UIColor *)placeholderColor;

/**
 设置有leftView的TextField且带有边框

 @param frame 尺寸大小
 @param textColor 字体颜色
 @param textFont 字体大小
 @param weight 字体权重
 @param textAlignment 字体的位置
 @param placeholder 占位文字
 @param borderColor 边框的颜色
 @param borderWidth 边框的宽度
 @return TextField
 */
+ (UITextField *)textFieldWithFrame:(CGRect)frame
                          textcolor:(UIColor *)textColor
                           textFont:(CGFloat)textFont
                      textAlignment:(NSTextAlignment)textAlignment
                        placeholder:(NSString *)placeholder
                         textWeight:(UIFontWeight)weight
                        borderColor:(UIColor *)borderColor
                         borderWith:(CGFloat)borderWidth
                       cornerRadius:(CGFloat)cornerRadius
                           leftView:(UIView *)vi;
@end
