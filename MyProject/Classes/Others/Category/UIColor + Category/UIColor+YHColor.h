//
//  UIColor+YHColor.h
//  MyProject
//
//  Created by LYH on 2019/9/19.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YHColor)

+ (UIColor *)colorWithHex:(long)hexColor;

+ (UIColor *)colorWithHex:(long)hexColor alpha:(CGFloat)alpha;

/**
 *  将16进制色值代码转换为UIColor对象
 *
 *  @param hexString 16进制色值，如"#DCDCDC"
 *
 *  @return UIColor对象
 */
+ (UIColor *)colorFromHexCode:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END
