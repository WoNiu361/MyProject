//
//  UITextField+THTextField.m
//  TH-ChiefApp
//
//  Created by 吕颜辉 on 2017/5/5.
//  Copyright © 2017年 吕颜辉-1140663172@qq.com. All rights reserved.
//

#import "UITextField+THTextField.h"

@implementation UITextField (THTextField)

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                               textcolor:(UIColor *)color
                                textFont:(CGFloat)textFont
                           textAlignment:(NSTextAlignment)textAlignment
                        placeholder:(NSString *)placeholder
                         textWeight:(UIFontWeight)weight {
    
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.textColor = color;
    textField.font = [UIFont systemFontOfSize:textFont weight:weight];
    textField.borderStyle = UITextBorderStyleNone;
    textField.textAlignment = textAlignment;
    textField.placeholder = placeholder;
    return textField;
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                          textcolor:(UIColor *)textColor
                           textFont:(CGFloat)textFont
                      textAlignment:(NSTextAlignment)textAlignment
                        placeholder:(NSString *)placeholder
                         textWeight:(UIFontWeight)weight
                        borderColor:(UIColor *)borderColor
                         borderWith:(CGFloat)borderWidth
                       cornerRadius:(CGFloat)cornerRadius {
    
    UITextField *textField = [self textFieldWithFrame:frame textcolor:textColor textFont:textFont textAlignment:textAlignment placeholder:placeholder textWeight:weight];
    textField.layer.borderWidth = borderWidth;
    textField.layer.borderColor = borderColor.CGColor;
    textField.layer.cornerRadius = cornerRadius;
    textField.layer.masksToBounds = true;
    return textField;
}

- (void)setPlaceholder:(NSString *)placeholder
       placeholderFont:(UIFont *)placeholderFont
      placeholderColor:(UIColor *)placeholderColor {
    if (@available(iOS 13.0, *)) {
        self.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:placeholder attributes:@{NSFontAttributeName:placeholderFont,NSForegroundColorAttributeName:placeholderColor}];
    } else {
        [self setValue:placeholderColor forKeyPath:@"_placeholderLabel.textColor"];
        [self setValue:placeholderFont forKeyPath:@"_placeholderLabel.font"];
        self.placeholder = placeholder;
    }
}

+ (UITextField *)textFieldWithFrame:(CGRect)frame
                          textcolor:(UIColor *)textColor
                           textFont:(CGFloat)textFont
                      textAlignment:(NSTextAlignment)textAlignment
                        placeholder:(NSString *)placeholder
                         textWeight:(UIFontWeight)weight
                        borderColor:(UIColor *)borderColor
                         borderWith:(CGFloat)borderWidth
                       cornerRadius:(CGFloat)cornerRadius
                           leftView:(UIView *)vi {
    
    UITextField *textField = [self textFieldWithFrame:frame textcolor:textColor textFont:textFont textAlignment:textAlignment placeholder:placeholder textWeight:weight];
    textField.layer.borderWidth = borderWidth;
    textField.layer.borderColor = borderColor.CGColor;
    textField.layer.cornerRadius = cornerRadius;
    textField.layer.masksToBounds = true;
    textField.leftView = vi;
    textField.leftViewMode = UITextFieldViewModeAlways;
    return textField;
}
@end
