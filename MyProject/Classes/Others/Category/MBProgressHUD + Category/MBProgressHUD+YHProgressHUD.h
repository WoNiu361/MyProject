//
//  MBProgressHUD+YHProgressHUD.h
//  MyProject
//
//  Created by LYH on 2019/8/1.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface MBProgressHUD (YHProgressHUD)

/**
 带有图片的成功提示
 
 @param successStr 文字提示
 @param view 要显示的view
 */
+ (void)showSuccess:(NSString *)successStr showView:(UIView *)view;

/**
 带有图片的错误提示
 
 @param errorStr 文字提示
 @param view 要显示的view
 */
+ (void)showError:(NSString *)errorStr showView:(UIView *)view;

#pragma mark - 文本提示
+ (void)showMessage:(NSString *)messageStr showView:(UIView *)view;

/**
 文本提示
 
 @param messageStr 内容
 @param title 标题
 @param view 要展示的view
 */
+ (void)showMessage:(NSString *)messageStr title:(NSString *)title showView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
