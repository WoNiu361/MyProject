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

@interface YHUISubviewsViewController ()

@end

@implementation YHUISubviewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"控件";
    self.navigationItem.leftBarButtonItem = nil;
    
    self.titleArray = @[@"tableView",@"collectionView",@"UIView",@"UITextField"];
    self.detailArray = @[@"cell折叠和选择",@"collectionView知识",@"view的相关知识",@"textField知识"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHTableViewController *tableVC           = [[YHTableViewController alloc] init];
    YHCollectionViewController *collectionVC = [[YHCollectionViewController alloc] init];
    YHMyUIViewController *viewVC             = [[YHMyUIViewController alloc] init];
    YHTextFieldViewController *textFieldVC   = [[YHTextFieldViewController alloc] init];
    NSArray *vcArray                         = @[tableVC,collectionVC,viewVC,textFieldVC];
    [self.navigationController pushViewController:vcArray[indexPath.row] animated:YES];
}

@end
