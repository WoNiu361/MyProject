//
//  YHUnfoldAndFoldViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHUnfoldAndFoldViewController.h"
#import "YHSelectModel.h"
#import "YHSelectIconTableViewCell.h"

@interface YHUnfoldAndFoldViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray<YHSelectModel *> *headModelArray;
@end

@implementation YHUnfoldAndFoldViewController

-(NSMutableArray<YHSelectModel *> *)headModelArray {
    if (_headModelArray == nil) {
        _headModelArray = [NSMutableArray array];
    }
    return _headModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"折合表";
    self.view.backgroundColor = kGlobalBgColor;
    
    for (NSInteger i = 0; i < 6;  i ++) {
        YHSelectModel *model = [[YHSelectModel alloc] init];
        model.headTitle = [NSString stringWithFormat:@"这是第%ld区标题",i];
        model.titleStr = [NSString stringWithFormat:@"这是第%ld行标题",i];
        model.isUnfold = false;
        [self.headModelArray addObject:model];
    }
    
    [self configureTableView:CGRectZero delegate:self dataSource:self tableViewStyle:UITableViewStyleGrouped bgColor:[UIColor clearColor] cellSeparatorStyle:UITableViewCellSeparatorStyleSingleLine separatorColor:[UIColor lightGrayColor]];
    [self.view addSubview:self.baseTableView];
    self.baseTableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    YHSelectModel *model = self.headModelArray[section];
    return model.isUnfold ? 4 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHSelectIconTableViewCell *cell = [YHSelectIconTableViewCell setupSelectIconCellWithTableView:tableView];
    YHSelectModel *model = self.headModelArray[indexPath.row];
    cell.selectModel = model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIControl *headControl = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, MainScreenWidth, 40)];
    headControl.backgroundColor = KRandomColor;
    [headControl addTarget:self action:@selector(whetherUnflod:) forControlEvents:UIControlEventTouchUpInside];
    headControl.tag = 10 + section;
    
    YHSelectModel *model = self.headModelArray[section];
    UILabel *headLabel = [UILabel labelWithTitle:model.headTitle withTitleColor:[UIColor whiteColor] withTitleFont:15 withFrame:headControl.bounds textWeigt:UIFontWeightMedium];
    headLabel.textAlignment = NSTextAlignmentCenter;
    [headControl addSubview:headLabel];
    
    return headControl;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 10)];
    vi.backgroundColor = [UIColor clearColor];
    return vi;
}

- (void)whetherUnflod:(UIControl *)sender {
    
    NSInteger tag = sender.tag - 10;
//    [self unfoldSingleOneWithTag:tag];
    [self moreSectionUnfoldWithTag:tag];
    
}
#pragma mark - 只展开一个区
- (void)unfoldSingleOneWithTag:(NSInteger)tag {
    
    YHSelectModel *selectModel = self.headModelArray[tag];
    if (selectModel.isUnfold) {
        selectModel.isUnfold = false;
    } else {
        selectModel.isUnfold = true;
        [self.headModelArray enumerateObjectsUsingBlock:^(YHSelectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isEqual:selectModel]) {
                obj.isUnfold = true;
            } else {
                obj.isUnfold = false;
            }
        }];
    }
    [self.baseTableView reloadData];
}
#pragma mark - 多个区可以展开
- (void)moreSectionUnfoldWithTag:(NSInteger)tag {
    
    YHSelectModel *selectModel = self.headModelArray[tag];
    selectModel.isUnfold = true;
    [self.headModelArray enumerateObjectsUsingBlock:^(YHSelectModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:selectModel]) {
            obj.isUnfold = true;
        } else {
            obj.isSelect = false;
        }
    }];
    [self.baseTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHSelectModel *selectModel = self.headModelArray[indexPath.row];
    selectModel.isSelect = !selectModel.isSelect;
//    [self.baseTableView reloadData];
    [self.baseTableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
}
@end
