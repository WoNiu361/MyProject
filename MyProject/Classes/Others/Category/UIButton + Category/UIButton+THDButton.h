//
//  UIButton+THDButton.h
//  TH-ChiefApp
//
//  Created by LYH on 17/3/7.
//  Copyright © 2017年 LYH-1140663172@qq.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tapBlock)(UIButton *sender);

@interface UIButton (THDButton)
/**
 设置带图片的button
 
 */
+ (UIButton *)buttonWithImage:(NSString *)imageName
                          withFrame:(CGRect)frame
                         withTarget:(id)target
                         withAction:(SEL)action;

/**
 设置选中和没有选中的颜色
 */
+ (UIButton *)buttonWithNormalTiltleColor:(UIColor *)normalColor
                         withSelectedTitleColor:(UIColor *)selectColor
                                      withTitle:(NSString *)title
                                  withTitleFont:(CGFloat)font
                                    withBgColor:(UIColor *)bgColor
                                      withFrame:(CGRect)frame
                                     withTarget:(id)target
                                     withAction:(SEL)action;

/**
 设置带边框的button

 */
+ (UIButton *)buttonWithLayer:(CGFloat)layer
                     withLayerWidth:(CGFloat)layerWidth
                     withLayerColor:(UIColor *)layerColor
                        withBgColor:(UIColor *)bgColor
                          withTitle:(NSString *)title
                     withTitleColor:(UIColor *)titleColor
                      withTitleFont:(CGFloat)font
                          withFrame:(CGRect)frame
                         withTarget:(id)target
                   withAction:(SEL)action
                       weight:(UIFontWeight)weight;

/**
 设置带有字体和底部颜色的button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                     withTitleColor:(UIColor *)titleColor
                           withFont:(CGFloat)titleFont
                        withBgColor:(UIColor *)bgColor
                          withFrame:(CGRect)frame
                         withTarget:(id)target
                         withAction:(SEL)action;

/** 
 设置带有文字和图片的button
 */
+ (UIButton *)btnWithImage:(NSString *)image
                       withFrame:(CGRect)frame
                       withTitle:(NSString *)title
                  withtitleColor:(UIColor *)Normalcolor
                 withSelectColor:(UIColor *)selectColor
                        withFont:(CGFloat)font
                      withTarget:(id)target
                      withAction:(SEL)action;

/**
 通过runtime,给button绑定一个block

 @param controlEvent 点击事件
 @param tapBlock block
 */
- (void)tapWithEvent:(UIControlEvents)controlEvent withBlock:(tapBlock)tapBlock;

/**
 设置带有文字的button
 */
+ (UIButton *)buttonWithTitle:(NSString *)title
                         titleColor:(UIColor *)color
                          titleFont:(CGFloat)font
                              frame:(CGRect)frame
                             target:(id)target
                             action:(SEL)action;



@end
