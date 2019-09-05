//
//  YHBaseViewController.h
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHBaseViewController : UIViewController

/**
 左上角的返回按钮
 */
- (void)returnBack;

@property (nonatomic, strong) UITableView *baseTableView;

/**
 创建表格
 
 @param frame 位置和大小
 @param delegateVC 代理
 @param dataSourceVC 代理
 @param style 表格类型
 @param bgColor 表格背景颜色
 @param separatorStyle cell之间的间隔线的样式
 @param separatorColor cell之间的间隔线的颜色
 */
- (void)configureTableView:(CGRect)frame
                  delegate:(id<UITableViewDelegate>)delegateVC
                dataSource:(id<UITableViewDataSource>)dataSourceVC
            tableViewStyle:(UITableViewStyle)style
                   bgColor:(UIColor *)bgColor
        cellSeparatorStyle:(UITableViewCellSeparatorStyle)separatorStyle
            separatorColor:(UIColor *)separatorColor;
@end

NS_ASSUME_NONNULL_END
