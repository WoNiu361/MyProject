//
//  AppDelegate.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH. All rights reserved.
//

#import "AppDelegate.h"
#import "LYHMianTabbarController.h"
#import "YHLoginViewController.h"
#import "YHURLConfiguration.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    LYHMianTabbarController *tabBarVC = [[LYHMianTabbarController alloc] init];
//    YHLoginViewController *loginVC = [[YHLoginViewController alloc] init];
    self.window.rootViewController = tabBarVC;
    
    [YHURLConfiguration shareConfigurate].environmentType = YHDevelopEnvironmentDevelopment;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

/*
 2019-10-21
 添加登录成功后返回数据归档 （YHAccount），使用YHAccountTool类保存、删除、获取用户信息。
 
 2020-01-14
 按钮反选并且控制下拉列表的弹出和收起；
 获取相册照片，选择照片，并标注选了几张，并且可以放大预览。
 线程组相关知识
 
 */
