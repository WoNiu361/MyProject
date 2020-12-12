//
//  UIViewController+YHViewConreoller.h
//  MyProject
//
//  Created by 吕颜辉 on 2020/9/9.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (YHViewConreoller)
/**
 *  @brief  隐藏NavigationBar底部分割线
 */
- (void)hideNavigationBarBottomLine;

/**
 *  @brief  显示NavigationBar底部分割线
 */
- (void)showNavigationBarBottomLine;

/**
获取view所在的控制器

@return UIViewController
*/
- (UIViewController *)getControllerViewLocated:(UIView *)locateView;

/**
获取view所在的导航控制器

@return UINavigationController
*/
- (UINavigationController *)getNavigationControllerViewLocated:(UIView *)locateView;
@end

NS_ASSUME_NONNULL_END
