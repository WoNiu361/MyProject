//
//  YHThreadViewController.m
//  MyProject
//
//  Created by 吕颜辉 on 2019/12/28.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHThreadViewController.h"
#import "YHDispatch_groupViewController.h"

@interface YHThreadViewController ()

@end

@implementation YHThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"线程知识";
    
    self.titleArray = @[@"dispatch_group"];
    self.detailArray = @[@"线程组"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        YHDispatch_groupViewController *groupVC = [[YHDispatch_groupViewController alloc] init];
        [self.navigationController pushViewController:groupVC animated:YES];
    }
}

@end
