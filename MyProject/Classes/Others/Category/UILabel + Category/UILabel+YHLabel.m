//
//  UILabel+YHLabel.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "UILabel+YHLabel.h"

@implementation UILabel (YHLabel)

+ (UILabel *)labelWithTitle:(NSString *)title
             withTitleColor:(UIColor *)color
              withTitleFont:(CGFloat)font
                  withFrame:(CGRect)frame
                  textWeigt:(UIFontWeight)weight {
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    //    [label setAdjustsFontSizeToFitWidth:YES];
    label.font = [UIFont systemFontOfSize:font weight:weight];
    return label;
}

+ (UILabel *)labelWithBgColor:(UIColor *)bgColor
                    withtitle:(NSString *)title
                     withFont:(CGFloat)font
               withTitleColor:(UIColor *)titleColor
                    withFrame:(CGRect)frame
                    textWeigt:(UIFontWeight)weight {
    
    UILabel *lab = [[UILabel alloc]initWithFrame:frame];
    lab.backgroundColor = bgColor;
    lab.text = title;
    lab.font = [UIFont systemFontOfSize:font weight:weight];
    lab.textColor = titleColor;
    //    [lab setAdjustsFontSizeToFitWidth:YES];
    return lab;
}

+ (void)changeLineSpaceForLabel:(UILabel *)label withSpace:(CGFloat)space {
    
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:space];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

+ (UILabel *)labelWithTitle:(NSString *)title
             withTitleColor:(UIColor *)color
              withTitleFont:(CGFloat)font
                  withFrame:(CGRect)frame
          withTextAligement:(NSTextAlignment)textAligment
                  textWeigt:(UIFontWeight)weight {
    
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.text = title;
    label.textColor = color;
    //    [label setAdjustsFontSizeToFitWidth:YES];
    label.font = [UIFont systemFontOfSize:font weight:weight];
    label.textAlignment = textAligment;
    return label;
}


@end
