//
//  YHSVProgressHUD.h
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHSVProgressHUD : NSObject

/**
 只显示提醒文字
 
 @param text 提醒文本
 */
+ (void)showMessageText:(NSString *)text;


/**
 显示加载状态 - 只用于详情页展示
 
 @param status 加载时的文本提示
 */
+ (void)showLoadingWithStatus:(NSString *)status;

/**
 显示加载状态
 
 @param status 加载时的文本提示
 */
+ (void)displayLoadingWithStatus:(NSString *)status;

/**
 显示加载成功
 
 @param status 提醒文本
 */
+ (void)showSuccessWithStatus:(NSString *)status;


/**
 显示加载失败
 
 @param status 提醒文本
 */
+ (void)showErrorWithStatus:(NSString *)status;


/**
 显示信息
 
 @param status 提醒文本
 */
+ (void)showInfoWithStatus:(NSString *)status;


/**
 隐藏HUD
 */
+ (void)dismiss;


@end

NS_ASSUME_NONNULL_END
