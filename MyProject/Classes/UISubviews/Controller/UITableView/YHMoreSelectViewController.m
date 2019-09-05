//
//  YHMoreSelectViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHMoreSelectViewController.h"
#import "YHSelectModel.h"
#import "YHSelectIconTableViewCell.h"

@interface YHMoreSelectViewController ()<UITableViewDelegate,UITableViewDataSource>
/**    <#*#>   */
@property (nonatomic, strong) NSMutableArray<YHSelectModel *> *modelArray;
/**    <#*#>   */
@property (nonatomic, strong) NSMutableArray<NSString *> *keyIdArray;
@end

@implementation YHMoreSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"多选";
    
    self.keyIdArray = [NSMutableArray array];
    self.modelArray = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i ++) {
        YHSelectModel *model = [[YHSelectModel alloc] init];
        model.titleStr = [NSString stringWithFormat:@"这是第%ld行",i];
        model.keyStr = [NSString stringWithFormat:@"%ld",i];
        if (i == 0) {
            model.isSelect = true;
            [self.keyIdArray addObject:model.keyStr];
        } else {
            model.isSelect = false;
        }
        [self.modelArray addObject:model];
    }
    
    [self configureTableView:CGRectZero delegate:self dataSource:self tableViewStyle:UITableViewStylePlain bgColor:[UIColor clearColor] cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.baseTableView];
    self.baseTableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHSelectIconTableViewCell *cell = [YHSelectIconTableViewCell setupSelectIconCellWithTableView:tableView];
    YHSelectModel *model = self.modelArray[indexPath.row];
    cell.selectModel = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHSelectModel *model = self.modelArray[indexPath.row];
    model.isSelect = !model.isSelect;
    if (model.isSelect) {
        [self.keyIdArray addObject:model.keyStr];
    } else {
        [self.keyIdArray removeObject:model.keyStr];
    }
    [self.baseTableView reloadData];
    
    NSLog(@"keyIdArray -     %@",self.keyIdArray);
}

@end
