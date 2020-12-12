//
//  YHBaseTextField.m
//  MyProject
//
//  Created by LYH on 2019/7/30.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHBaseTextField.h"

static NSString *const placerholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation YHBaseTextField

-(instancetype)initWithFrame:(CGRect)frame
                   imageName:(NSString *)imageName
                 placeholder:(NSString *)placeholder
             placeHolderFont:(CGFloat)font
            placeHolderColor:(UIColor *)color {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        self.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
        //设置清楚按钮的状态
        self.clearButtonMode = UITextFieldViewModeAlways;
        
        UIImageView *iconImageView = KImageView(imageName);
        iconImageView.frame = CGRectMake(5, 0, iconImageView.image.size.width, iconImageView.image.size.height);
        iconImageView.contentMode = UIViewContentModeCenter;
        self.leftView = iconImageView;
        self.leftViewMode = UITextFieldViewModeAlways;
        
        //右下角返回键盘的类型
        self.returnKeyType = UIReturnKeySend;//带有搜索
//        self.keyboardType = UIKeyboardTypeNumberPad;//纯数字键盘
//        self.keyboardType = UIKeyboardTypeDecimalPad;//小数点键盘
//        self.keyboardType = UIKeyboardTypeDefault;
//        self.keyboardType = UIKeyboardTypeTwitter;
        self.borderStyle   = UITextBorderStyleRoundedRect;
        //设置光标的颜色
        self.tintColor = [UIColor blackColor];
        
        if (@available(iOS 13.0, *)) {
            self.attributedPlaceholder = [[NSMutableAttributedString alloc]initWithString:placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14 weight:UIFontWeightRegular],NSForegroundColorAttributeName:color}];
        } else {
            [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];//更改占位符的颜色
            [self setValue:[UIFont systemFontOfSize:font weight:UIFontWeightRegular] forKeyPath:@"_placeholderLabel.font"]; //更改占位符的字体大小
            self.placeholder = placeholder;
        }
        
//        self.placeholder = placeholder;
//        //更改占位符的颜色
//        [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
//        //更改占位符的字体大小
//        [self setValue:[UIFont systemFontOfSize:font weight:UIFontWeightMedium] forKeyPath:@"_placeholderLabel.font"];
        //设置输入区域的背景颜色
//        [self setValue:[UIColor lightGrayColor] forKeyPath:@"textContentView.backgroundColor"];
//        [self setValue:[UIColor blackColor] forKeyPath:@"backgroundView.backgroundColor"];
//        [self setValue:@(50) forKeyPath:@"padding"];
        
////        UIView *vi = [UIView viewWithBackgroundColor:[UIColor redColor] frame:CGRectMake(0, 0, 20, 20)];
//        UIImageView *iconImageView1 = KImageView(imageName);
//        [self setValue:iconImageView forKeyPath:@"iconView"];
//        iconImageView1.frame = CGRectMake(0, 0, iconImageView.image.size.width, iconImageView.image.size.height);
//        self.rightView = iconImageView1;
//        self.rightViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}
#pragma mark - 改变左边view的位置
- (CGRect)leftViewRectForBounds:(CGRect)bounds{
    CGRect rect = [super leftViewRectForBounds:bounds];
    rect.origin.x += 10;
    return rect;
}

#pragma mark - 重写占位符的x值
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    CGRect placeholderRect = [super placeholderRectForBounds:bounds];
    placeholderRect.origin.x += 15;
    return placeholderRect;
}

#pragma mark - 重写文字输入时的x值
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect editingRect = [super editingRectForBounds:bounds];
    editingRect.origin.x += 5;
    
    return editingRect;
}

#pragma mark - 重写文字显示时的X值
- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect textRect = [super textRectForBounds:bounds];
    textRect.origin.x += 5;
    return textRect;
}

#pragma mark - 修改占位符的属性，可以设置一次设置多个属性
//- (void)drawPlaceholderInRect:(CGRect)rect{
//    [super drawPlaceholderInRect:rect];
//    [[UIColor orangeColor] set];
//    [self.placeholder drawInRect:rect withAttributes:@{
//                                                       NSFontAttributeName:[UIFont systemFontOfSize:15],
//                                                       NSForegroundColorAttributeName:[UIColor orangeColor]
//                                                       }];
//}

#pragma mark - 当前文本框聚焦时就会调用
- (BOOL)becomeFirstResponder {
    // 修改占位文字颜色
    [self setValue:self.textColor forKeyPath:placerholderColorKeyPath];
    return [super becomeFirstResponder];
}

#pragma mark - 当前文本框失去焦点时就会调用
- (BOOL)resignFirstResponder {
    // 修改占位文字颜色
    [self setValue:[UIColor grayColor] forKeyPath:placerholderColorKeyPath];
    return [super resignFirstResponder];
}

@end
