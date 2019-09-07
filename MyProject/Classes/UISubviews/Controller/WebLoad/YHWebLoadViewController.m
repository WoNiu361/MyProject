//
//  YHWebLoadViewController.m
//  MyProject
//
//  Created by 吕颜辉 on 2019/9/7.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHWebLoadViewController.h"
#import <SafariServices/SafariServices.h>
#import "YHBaseWebLoadViewController.h"
#import "YHWebViewTestViewController.h"

@interface YHWebLoadViewController ()

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
        [self presentViewController:safariVC animated:YES completion:nil];
    } else {
//        YHBaseWebLoadViewController *webLoadVC = [[YHBaseWebLoadViewController alloc] init];
        YHWebViewTestViewController *webLoadVC = [[YHWebViewTestViewController alloc] init];
        [self.navigationController pushViewController:webLoadVC animated:YES];
    }
}

@end
