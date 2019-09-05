//
//  YHMainTableViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHMainTableViewController.h"

@interface YHMainTableViewController ()

@end
static  NSString *const mainID = @"MainTableViewController";
@implementation YHMainTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:UITableViewStylePlain];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kGlobalBgColor;
    
    self.titleArray = [NSArray array];
    self.detailArray = [NSArray array];
    
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.separatorColor = [UIColor redColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mainID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:mainID];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.detailTextLabel.text = self.detailArray[indexPath.row];
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"iconRight"]];
    //cell未选中时默认的背景颜色是白色的
    //点击背景没有变化
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
