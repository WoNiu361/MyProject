//
//  YHFunctionViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHFunctionViewController.h"
#import "YHStringViewController.h"
#import "YHBouncesTableViewController.h"
#import "YHDateViewController.h"
#import "YHRunTimeViewController.h"
#import "YHAFNTableViewController.h"

@interface YHFunctionViewController ()

@end

@implementation YHFunctionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"功能";
    self.view.backgroundColor = KRandomColor;
    self.navigationItem.leftBarButtonItem = nil;
    
    self.titleArray = @[@"NSString",@"弹框",@"时间",@"RunTime",@"AFN封装"];
    self.detailArray = @[@"string知识",@"一些列弹框",@"时间相关知识",@"运行时相关知识",@""];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHStringViewController *stringVC        = [[YHStringViewController alloc] init];
    YHBouncesTableViewController *bouncesVC = [[YHBouncesTableViewController alloc] init];
    YHDateViewController *dateVC            = [[YHDateViewController alloc] init];
    YHRunTimeViewController *runTimeVC      = [[YHRunTimeViewController alloc] init];
    YHAFNTableViewController *afnVC         = [[YHAFNTableViewController alloc] init];
    NSArray<UIViewController *> *vcArray    = @[stringVC,bouncesVC,dateVC,runTimeVC,afnVC];
    [self.navigationController pushViewController:vcArray[indexPath.row] animated:YES];
}

@end
