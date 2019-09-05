//
//  YHSelectIconTableViewCell.h
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSelectModel;

NS_ASSUME_NONNULL_BEGIN

@interface YHSelectIconTableViewCell : UITableViewCell

+ (instancetype)setupSelectIconCellWithTableView:(UITableView *)tableView;
/**  方法一：通过model控制选择和反选   */
@property (nonatomic, strong) YHSelectModel *selectModel;
@end

NS_ASSUME_NONNULL_END
