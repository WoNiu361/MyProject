//
//  UIBarButtonItem+YHBarButtonItem.h
//  MyProject
//
//  Created by LYH on 2019/9/7.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (YHBarButtonItem)

/**
 创建UIBarButtonItem,通过义UIButton自定义

 @param image 普通图片
 @param highImage 高亮图片
 @param target target
 @param action action
 @return self
 */
+ (instancetype)itemWithImage:(NSString *)image
                    highImage:(NSString *)highImage
                       target:(id)target
                       action:(SEL)action;

/**
 创建UIBarButtonItem

 */
+ (UIBarButtonItem *)itemWithImage:(NSString *)imageName
                            target:(id)target
                            action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
