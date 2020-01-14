//
//  YHSelectStyleViewController.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "YHSelectStyleViewController.h"
#import "YHGooodsOperateStyleView.h"
#import "YHSelectModel.h"

#import <UIKit/UIKit.h>

@interface YHSelectStyleViewController ()<YHGooodsOperateStyleViewDelegate>
@property (nonatomic, strong) NSMutableArray<YHSelectStyleModel *> *styleModelArray;
@property (nonatomic, weak) YHGooodsOperateStyleView               *styleView;
@property (nonatomic, weak) YHStyleRankView                        *rankView;
@property (nonatomic, strong) NSMutableArray<YHSelectStyleModel *> *rankModelArray;
@end

@implementation YHSelectStyleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"按钮控制表格";
    
    self.styleModelArray = [NSMutableArray array];
    self.rankModelArray = [NSMutableArray array];
    
    NSArray<NSString *> *titleArray = @[@"排序",@"销售量",@"全部分组",@"批量"];
    NSArray<NSString *> *imageArray = @[@"icon_down_expand",@"icon_down_expand",@"icon_down_expand",@""];
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        YHSelectStyleModel *model = [[YHSelectStyleModel alloc] init];
        model.title = obj;
        model.pic = imageArray[idx];
        model.isSelect = false;
        model.markTag = 20 + idx;
        [self.styleModelArray addObject:model];
    }];
    
    NSArray<NSString *> *rankArray = @[@"发布时间",@"价格升序",@"价格降序",@"库存降序",@"库存升序"];
    [rankArray enumerateObjectsUsingBlock:^(NSString * _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
        YHSelectStyleModel *model = [[YHSelectStyleModel alloc] init];
        model.title = title;
        model.isSelect = false;
        [self.rankModelArray addObject:model];
    }];
    
    YHGooodsOperateStyleView *styleView = [[YHGooodsOperateStyleView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, 50) title:self.styleModelArray];
    styleView.delegate = self;
    [self.view addSubview:styleView];
    self.styleView = styleView;
}

- (void)view:(YHGooodsOperateStyleView *)entranceView clickButtonWithTag:(NSInteger)buttonTag selectState:(NSString *)selectState {
    
    PPLog(@"tag -  %ld -   %@",(long)buttonTag,selectState);
    switch (buttonTag) {
        case OperateStyleRank: {//排序
            kFuncLogo;
            YHStyleRankView *rankView = [[YHStyleRankView alloc] initWithFrame:CGRectMake(0, self.styleView.height , MainScreenWidth, self.view.height - self.styleView.height) titleArray:self.rankModelArray];
            [self.view addSubview:rankView];
            self.rankView = rankView;
        }
            break;
            
        case OperateStyleSaleAmount: {//销售量
            kFuncLogo;
            [self.rankView removeFromSuperview];
        }
            break;
        case OperateStyleAllGroup: {//全部分组
            kFuncLogo;
            [self.rankView removeFromSuperview];
        }
            break;
        case OperateStyleWholeEdit: {//批量
            kFuncLogo;
            [self.rankView removeFromSuperview];
            
            
        }
            break;
            
        default:
            break;
    }
}

@end
