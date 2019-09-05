//
//  UIButton+THDButton.m
//  TH-ChiefApp
//
//  Created by LYH on 17/3/7.
//  Copyright © 2017年 LYH-1140663172@qq.com. All rights reserved.
//

#import "UIButton+THDButton.h"
#import <objc/runtime.h>

static const void *buttonKey = &buttonKey;

@implementation UIButton (THDButton)
+ (UIButton *)buttonWithImage:(NSString *)imageName
                          withFrame:(CGRect)frame
                         withTarget:(id)target
                         withAction:(SEL)action{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithNormalTiltleColor:(UIColor *)normalColor
                         withSelectedTitleColor:(UIColor *)selectColor
                                      withTitle:(NSString *)title
                                  withTitleFont:(CGFloat)font
                                    withBgColor:(UIColor *)bgColor
                                      withFrame:(CGRect)frame
                                     withTarget:(id)target
                                     withAction:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectColor forState:UIControlStateSelected];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.backgroundColor = bgColor;
    button.frame = frame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}


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
                       weight:(UIFontWeight)weight{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.layer.cornerRadius = layer;
    button.layer.borderWidth = layerWidth;
    button.layer.borderColor = layerColor.CGColor;
    button.backgroundColor = bgColor;
    button.layer.masksToBounds = YES;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font weight:weight];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                     withTitleColor:(UIColor *)titleColor
                           withFont:(CGFloat)titleFont
                        withBgColor:(UIColor *)bgColor
                          withFrame:(CGRect)frame
                         withTarget:(id)target
                         withAction:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:titleFont];
    button.backgroundColor = bgColor;
    button.frame = frame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+ (UIButton *)btnWithImage:(NSString *)image
                       withFrame:(CGRect)frame
                       withTitle:(NSString *)title
                  withtitleColor:(UIColor *)Normalcolor
                 withSelectColor:(UIColor *)selectColor
                        withFont:(CGFloat)font
                      withTarget:(id)target
                      withAction:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:Normalcolor forState:UIControlStateNormal];
    [button setTitleColor:selectColor forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)tapWithEvent:(UIControlEvents)controlEvent withBlock:(tapBlock)tapBlock {
    
    objc_setAssociatedObject(self, buttonKey, tapBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self removeTarget:self action:@selector(buttonClick:) forControlEvents:controlEvent];
    [self addTarget:self action:@selector(buttonClick:) forControlEvents:controlEvent];
}

- (void)buttonClick:(UIButton *)sender {
    
    tapBlock tapBlock = objc_getAssociatedObject(sender, buttonKey);
    if (tapBlock) {
        tapBlock(sender);
    }
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                         titleColor:(UIColor *)color
                          titleFont:(CGFloat)font
                              frame:(CGRect)frame
                             target:(id)target
                             action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    button.frame = frame;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}



@end
