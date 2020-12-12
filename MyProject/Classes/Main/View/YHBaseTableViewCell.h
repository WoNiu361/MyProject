//
//  YHBaseTableViewCell.h
//  MyProject
//
//  Created by 吕颜辉 on 2018/2/12.
//  Copyright © 2018 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHBaseTableViewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier;

- (void)setupSubviews;

/**   是否改变cell的frame,默认为NO    */
@property (nonatomic, assign) BOOL changeFrame;

@end

NS_ASSUME_NONNULL_END


/**
 eg：
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     WXNameCardTableViewCell *cell = [WXNameCardTableViewCell setupNameCardCellWithTableView:tableView];
     cell.changeFrame = true;
     return cell;
 }
 */
