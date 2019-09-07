//
//  UIBarButtonItem+YHBarButtonItem.m
//  MyProject
//
//  Created by 吕颜辉 on 2019/9/7.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "UIBarButtonItem+YHBarButtonItem.h"

@implementation UIBarButtonItem (YHBarButtonItem)

+ (instancetype)itemWithImage:(NSString *)image
                    highImage:(NSString *)highImage
                       target:(id)target
                       action:(SEL)action {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithImage:(NSString *)imageName target:(id)target action:(SEL)action {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithImage:[kImageNamed(imageName) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:target action:action];
    return item;
}

@end
