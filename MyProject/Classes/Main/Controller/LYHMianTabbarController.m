//
//  LYHMianTabbarController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "LYHMianTabbarController.h"
#import "YHUISubviewsViewController.h"
#import "YHFunctionViewController.h"
#import "YHAnimationViewController.h"
#import "YHNavigationViewController.h"

@interface LYHMianTabbarController ()

@end

@implementation LYHMianTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTabBarTheme];
    
    [self addChildViewController];
}

#pragma mark - 设置tabbar主题
- (void)setupTabBarTheme {
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular],
                                                        NSForegroundColorAttributeName:kRGBColor(153, 153, 153)
                                                        } forState:UIControlStateNormal];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{
                                                        NSFontAttributeName:[UIFont systemFontOfSize:10 weight:UIFontWeightRegular],
                                                        NSForegroundColorAttributeName:kRGBColor(253, 93, 132)
                                                        } forState:UIControlStateSelected];
}

- (void)addChildViewController {
    
    YHUISubviewsViewController *subviewsVC = [[YHUISubviewsViewController alloc] init];
    [self addChildViewController:subviewsVC itemImage:@"UISubviews" itemTitle:@"UI控件"];
    
    YHFunctionViewController *functionVC = [[YHFunctionViewController alloc] init];
    [self addChildViewController:functionVC itemImage:@"function" itemTitle:@"功能分类"];
    
    YHAnimationViewController *animationVC = [[YHAnimationViewController alloc] init];
    [self addChildViewController:animationVC itemImage:@"Animation" itemTitle:@"动画"];
}

- (void)addChildViewController:(UIViewController *)childController
                     itemImage:(NSString *)imageName itemTitle:(NSString *)title {
    
    UITabBarItem *item = childController.tabBarItem;
    item.title = title;
    
    NSString *selectItemName = [imageName stringByAppendingString:@"_selected"];
    UIImage *normalImage = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectImage = [[UIImage imageNamed:selectItemName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    item.image = normalImage;
    item.selectedImage = selectImage;
    
    YHNavigationViewController *nav = [[YHNavigationViewController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

@end
