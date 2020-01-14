//
//  YHGooodsOperateStyleView.h
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHGooodsOperateStyleView;
@class YHSelectStyleModel;

typedef NS_ENUM(NSInteger,OperateStyle) {
    OperateStyleRank            = 20,  //排序
    OperateStyleSaleAmount,            //销售量
    OperateStyleAllGroup,              //全部分组
    OperateStyleWholeEdit              //批量
};

NS_ASSUME_NONNULL_BEGIN

@protocol YHGooodsOperateStyleViewDelegate <NSObject>

- (void)view:(YHGooodsOperateStyleView *)entranceView clickButtonWithTag:(NSInteger)buttonTag selectState:(NSString *)selectState;
@end

@interface YHGooodsOperateStyleView : UIView

- (instancetype)initWithFrame:(CGRect)frame title:(NSMutableArray<YHSelectStyleModel *> *)titleArray;

@property (nonatomic, weak) id<YHGooodsOperateStyleViewDelegate>delegate;

@end



@interface YHStyleRankView : UIView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray<YHSelectStyleModel *> *)rankModelArray;

- (void)showRankData;

@end

NS_ASSUME_NONNULL_END
