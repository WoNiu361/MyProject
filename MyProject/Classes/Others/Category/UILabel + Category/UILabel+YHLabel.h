//
//  UILabel+YHLabel.h
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (YHLabel)

/**
 *  一般的label
 */
+ (UILabel *)labelWithTitle:(NSString *)title
             withTitleColor:(UIColor *)color
              withTitleFont:(CGFloat)font
                  withFrame:(CGRect)frame
                  textWeigt:(UIFontWeight)weight;

/**
 *  带背景颜色的label
 */
+ (UILabel *)labelWithBgColor:(UIColor *)bgColor
                    withtitle:(NSString *)title
                     withFont:(CGFloat)font
               withTitleColor:(UIColor *)titleColor
                    withFrame:(CGRect)frame
                    textWeigt:(UIFontWeight)weight;

/**
 *  改变行间距
 */
+ (void)changeLineSpaceForLabel:(UILabel *)label
                      withSpace:(CGFloat)space;

/**
 *  一般的label 加上label文本的位置
 */
+ (UILabel *)labelWithTitle:(NSString *)title
             withTitleColor:(UIColor *)color
              withTitleFont:(CGFloat)font
                  withFrame:(CGRect)frame
          withTextAligement:(NSTextAlignment)textAligment
                  textWeigt:(UIFontWeight)weight;


@end

NS_ASSUME_NONNULL_END
