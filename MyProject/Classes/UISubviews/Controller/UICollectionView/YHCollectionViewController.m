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
#import "YHGetPhotoAlbumImageViewController.h"


@interface YHCollectionViewController ()

@end

@implementation YHCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"collectionView知识";
    
    self.titleArray = @[@"移动collectionViewCell",@"自定义UICollectionViewFlowLayout",@"获取相册图片"];
    self.detailArray = @[@"移动cell",@"自定义",@"模仿微信选择图片"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHMoveCollectionViewCellViewController *moveVC = [[YHMoveCollectionViewCellViewController alloc] init];
    YHCustomCollectionViewViewController *customVC = [[YHCustomCollectionViewViewController alloc] init];
    YHGetPhotoAlbumImageViewController *imageVC    = [[YHGetPhotoAlbumImageViewController alloc] init];

    NSArray *vcArray = @[moveVC,customVC,imageVC];
    [self.navigationController pushViewController:vcArray[indexPath.row] animated:YES];
}



@end
