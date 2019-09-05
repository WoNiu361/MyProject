//
//  YHBouncesTableViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/31.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHBouncesTableViewController.h"
#import "YHSystemBouncesViewController.h"
#import "YHCustomBouncesViewController.h"

@interface YHBouncesTableViewController ()

@end

@implementation YHBouncesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"弹框提醒";
    
    self.titleArray = @[@"系统弹框",@"自定义"];
    self.detailArray = @[@"更改属性",@"一些自定义的弹框"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHSystemBouncesViewController *systemVC = [[YHSystemBouncesViewController alloc] init];
    YHCustomBouncesViewController *customVC = [[YHCustomBouncesViewController alloc] init];
    NSArray<UIViewController *> *vcArray = @[systemVC,customVC];
    [self.navigationController pushViewController:vcArray[indexPath.row] animated:YES];
}

@end
