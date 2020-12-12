//
//  UIViewController+YHViewConreoller.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/9/9.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "UIViewController+YHViewConreoller.h"

@implementation UIViewController (YHViewConreoller)

/**
 *  @brief  隐藏NavigationBar底部分割线
 */
- (void)hideNavigationBarBottomLine
{
    [self navigationBarBottomLineInView:self.navigationController.navigationBar].hidden = YES;
}

/**
 *  @brief  显示NavigationBar底部分割线
 */
- (void)showNavigationBarBottomLine
{
    [self navigationBarBottomLineInView:self.navigationController.navigationBar].hidden = NO;
}

- (UIView *)navigationBarBottomLineInView:(UIView *)view
{
    if (![view isKindOfClass:[UIView class]]) {
        return nil;
    }
    
    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIView *imageView = [self navigationBarBottomLineInView:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


#pragma mark - 获取view所在的控制器
- (UIViewController *)getControllerViewLocated:(UIView *)locateView {
    
    for (UIView *next = [locateView superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - 获取view所在的导航控制器
- (UINavigationController *)getNavigationControllerViewLocated:(UIView *)locateView {
    
    for (UIView *next = [locateView superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]]) {
            return (UINavigationController *)nextResponder;
        }
    }
    return nil;
}


@end
