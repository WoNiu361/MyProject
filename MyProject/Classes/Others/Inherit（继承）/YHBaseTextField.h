//
//  YHBaseTextField.h
//  MyProject
//
//  Created by LYH on 2019/7/30.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHBaseTextField : UITextField

-(instancetype)initWithFrame:(CGRect)frame
                   imageName:(NSString *)imageName
                 placeholder:(NSString *)placeholder
             placeHolderFont:(CGFloat)font
            placeHolderColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
