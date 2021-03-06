//
//  YHUISubviewsViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHUISubviewsViewController.h"
#import "YHTableViewController.h"
#import "YHCollectionViewController.h"
#import "YHMyUIViewController.h"
#import "YHTextFieldViewController.h"
#import "YHWebLoadViewController.h"
#import "YHLoadAcvivityCoverViewController.h"
#import "YHSelectStyleViewController.h"

@interface YHUISubviewsViewController ()

@end

@implementation YHUISubviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"控件";
    self.navigationItem.leftBarButtonItem = nil;
    
    self.titleArray = @[@"tableView",@"collectionView",@"UIView",@"UITextField",@"LoadWeb",@"UIActivityIndicatorView",@"按钮控制表格"];
    self.detailArray = @[@"cell折叠和选择",@"collectionView知识",@"view的相关知识",@"textField知识",@"加载网页",@"系统菊花的用法",@""];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHTableViewController *tableVC             = [[YHTableViewController alloc] init];
    YHCollectionViewController *collectionVC   = [[YHCollectionViewController alloc] init];
    YHMyUIViewController *viewVC               = [[YHMyUIViewController alloc] init];
    YHTextFieldViewController *textFieldVC     = [[YHTextFieldViewController alloc] init];
    YHWebLoadViewController *webLoadVC         = [[YHWebLoadViewController alloc] init];
    YHLoadAcvivityCoverViewController *coverVC = [[YHLoadAcvivityCoverViewController alloc] init];
    YHSelectStyleViewController *styleVC       = [[YHSelectStyleViewController alloc] init];
    NSArray *vcArray                           = @[tableVC,collectionVC,viewVC,textFieldVC,webLoadVC,coverVC,styleVC];
    [self.navigationController pushViewController:vcArray[indexPath.row] animated:YES];
}

@end
