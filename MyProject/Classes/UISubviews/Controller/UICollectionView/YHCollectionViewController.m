//
//  YHCollectionViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/29.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHCollectionViewController.h"
#import "YHMoveCollectionViewCellViewController.h"
#import "YHCustomCollectionViewViewController.h"

@interface YHCollectionViewController ()

@end

@implementation YHCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"collectionView知识";
    
    self.titleArray = @[@"移动collectionViewCell",@"自定义UICollectionViewFlowLayout",];
    self.detailArray = @[@"移动cell",@"自定义"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHMoveCollectionViewCellViewController *moveVC = [[YHMoveCollectionViewCellViewController alloc] init];
    YHCustomCollectionViewViewController *customVC = [[YHCustomCollectionViewViewController alloc] init];
    NSArray *vcArray = @[moveVC,customVC];
    [self.navigationController pushViewController:vcArray[indexPath.row] animated:YES];
}



@end
