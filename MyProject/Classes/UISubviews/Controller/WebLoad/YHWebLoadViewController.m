//
//  YHWebLoadViewController.m
//  MyProject
//
//  Created by LYH on 2019/9/7.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHWebLoadViewController.h"
#import <SafariServices/SafariServices.h>
#import "YHBaseWebLoadViewController.h"
#import "YHWebViewTestViewController.h"

@interface YHWebLoadViewController ()<SFSafariViewControllerDelegate>

@end

@implementation YHWebLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加载网页";
    
    self.titleArray = @[@"SFSafariViewController",@"WKWebView"];
    self.detailArray = @[@"SFSafariViewController加载网页",@"WKWebView加载网页"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:URL(@"https://www.baidu.com")];
        safariVC.delegate = self;
        if (@available(iOS 10.0, *)) {//设置导航条下面进度条的颜色
            safariVC.preferredControlTintColor = [UIColor orangeColor];
        } else {
            // Fallback on earlier versions
        }
        if (@available(iOS 11.0, *)) {//当用户滚动web内容时，指示SFSafariViewController是否应启用导航栏的折叠和底部工具栏的隐藏，默认是YES。
            safariVC.configuration.barCollapsingEnabled = false;
        } else {
            // Fallback on earlier versions
        }
        if (@available(iOS 11.0, *)) {//左上角按钮的样式左上角按钮的样式
            safariVC.dismissButtonStyle = SFSafariViewControllerDismissButtonStyleCancel;
        } else {
            // Fallback on earlier versions
        }
        [self presentViewController:safariVC animated:YES completion:nil];
        //详细用法，参考：https://www.jianshu.com/p/68f8c724ac78
    } else {
//        YHBaseWebLoadViewController *webLoadVC = [[YHBaseWebLoadViewController alloc] init];
        YHWebViewTestViewController *webLoadVC = [[YHWebViewTestViewController alloc] init];
        [self.navigationController pushViewController:webLoadVC animated:YES];
    }
}

/**
 点击当导航栏左边的按钮
 当用户单击导航栏左边的按钮调用委托回调。在这个调用中，视图控制器被销毁。
 
 @param controller 当前控制
 */
- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    NSLog(@"controller -   ");
}

/**
 初始URL加载已完成时调用
 
 当SFSafariViewController完成加载传递给初始化器的URL时，将调用此方法。
 它不会在相同的SFSafariViewController实例中调用任何后续页面加载。
 
 @param controller 当前控制
 @param didLoadSuccessfully 是否加载成功，如果加载成功，则为YES;如果加载失败，则为NO。
 */
- (void)safariViewController:(SFSafariViewController *)controller didCompleteInitialLoad:(BOOL)didLoadSuccessfully {
    NSLog(@"didLoadSuccessfully -  ");
}



- (void)safariViewController:(SFSafariViewController *)controller initialLoadDidRedirectToURL:(NSURL *)URL {
    
}

- (NSArray<UIActivityType> *)safariViewController:(SFSafariViewController *)controller excludedActivityTypesForURL:(NSURL *)URL title:(nullable NSString *)title {
    
    NSLog(@"URL/title -  %@ -  %@",URL,title);
    return @[UIActivityTypePostToFacebook];
}

/**
 当用户点击action按钮后，视图控制器将要显示UIActivityViewController时调用。
 用户单击了操作按钮。
 
 @param controller SFSafariViewController
 @param URL <#URL description#>
 @param title <#title description#>
 @return <#return value description#>
 */
- (NSArray<UIActivity *> *)safariViewController:(SFSafariViewController *)controller activityItemsForURL:(NSURL *)URL title:(nullable NSString *)title {
    return [NSArray array];
}

@end
