//
//  YHTableViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHTableViewController.h"
#import "YHMoreSelectViewController.h"
#import "YHSelectOneViewController.h"
#import "YHUnfoldAndFoldViewController.h"

@interface YHTableViewController ()

@end

@implementation YHTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"tableView折叠和多选";
    
    self.titleArray = @[@"多选",@"单选",@"折合表"];
    self.detailArray = @[@"选择多个cell",@"只选中一个cell",@"展开和收起cell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHMoreSelectViewController *moreSelectVC = [[YHMoreSelectViewController alloc] init];
    YHSelectOneViewController *selectOneVC   = [[YHSelectOneViewController alloc] init];
    YHUnfoldAndFoldViewController *foldVC    = [[YHUnfoldAndFoldViewController alloc] init];
    NSArray *vcArray                         = @[moreSelectVC,selectOneVC,foldVC];
    [self.navigationController pushViewController:vcArray[indexPath.row] animated:YES];
}

@end
