//
//  YHMainTableViewController.h
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHMainTableViewController : UITableViewController

/**    标题   */
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
/**    详细标题   */
@property (nonatomic, strong) NSArray<NSString *> *detailArray;
@end

NS_ASSUME_NONNULL_END
