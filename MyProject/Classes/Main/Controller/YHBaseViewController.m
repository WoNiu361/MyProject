//
//  YHBaseViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHBaseViewController.h"

@interface YHBaseViewController ()

@end

@implementation YHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = kGlobalBgColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[kImageNamed(@"navigation_back") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(returnBack)];
}

- (void)returnBack {
    
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)configureTableView:(CGRect)frame
                  delegate:(id<UITableViewDelegate>)delegateVC
                dataSource:(id<UITableViewDataSource>)dataSourceVC
            tableViewStyle:(UITableViewStyle)style
                   bgColor:(UIColor *)bgColor
        cellSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
            separatorColor:(UIColor *)separatorColor {
    
    self.baseTableView = [[UITableView alloc]initWithFrame:frame style:style];
    self.baseTableView.delegate = delegateVC;
    self.baseTableView.dataSource = dataSourceVC;
    self.baseTableView.backgroundColor = bgColor;
    
    self.baseTableView.estimatedRowHeight = 0;
    self.baseTableView.estimatedSectionHeaderHeight = 0;
    self.baseTableView.estimatedSectionFooterHeight = 0;
    
    self.baseTableView.separatorStyle = separatorStyle;
    self.baseTableView.separatorColor = separatorColor;
    
    //    self.baseTableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    //    if (@available(iOS 11, *)) {
    //        self.baseTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    //    } else {
    //        self.automaticallyAdjustsScrollViewInsets = false;
    //    }
    
    if (is_iPhoneXSeries) {
        self.baseTableView.contentInset = UIEdgeInsetsMake(0, 0, 34, 0);
        self.baseTableView.scrollIndicatorInsets = self.baseTableView.contentInset;
    }
}

@end
