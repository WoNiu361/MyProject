//
//  YHNavigationViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHNavigationViewController.h"

@interface YHNavigationViewController ()<UINavigationControllerDelegate>

@end

@implementation YHNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+ (void)load {
    
    [self setNavigationItemTheme];
    
    [self setNavigationBarTheme];
}

#pragma mark - 设置导航标题属性
+ (void)setNavigationItemTheme {
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    [barItem setTitleTextAttributes:@{
                                      NSFontAttributeName:[UIFont systemFontOfSize:19 weight:UIFontWeightMedium],
                                      NSForegroundColorAttributeName:[UIColor whiteColor]
                                      } forState:UIControlStateNormal];
}

+ (void)setNavigationBarTheme {
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    NSString *navBarBg = @"navigationbar_bg";
    [navBar setBackgroundImage:[UIImage imageNamed:navBarBg] forBarMetrics:UIBarMetricsDefault];
    
    // 设置导航栏标题颜色
    NSMutableDictionary *textAttributes = [NSMutableDictionary dictionary];
    textAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttributes[NSFontAttributeName] = [UIFont systemFontOfSize:19 weight:UIFontWeightMedium];
    [navBar setTitleTextAttributes:textAttributes];
    
    //是否隐藏导航条下面的那条线
//    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}

#pragma mark - 拦截push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = true;
    }
    if (viewController.navigationItem.leftBarButtonItem == nil && self.viewControllers.count > 0) {
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"navigation_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(backItem)];
        viewController.navigationItem.leftBarButtonItem = backItem;
    }
    self.interactivePopGestureRecognizer.delegate = (id)self;
    
    [super pushViewController:viewController animated:animated];
}

- (void)backItem {
    
    [self.view endEditing:YES];
    [self popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
@end
