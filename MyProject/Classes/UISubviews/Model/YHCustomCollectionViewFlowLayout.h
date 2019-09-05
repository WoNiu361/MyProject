//
//  YHCustomCollectionViewFlowLayout.h
//  MyProject
//
//  Created by LYH on 2019/7/30.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FlowLayoutType){
    FlowLayoutTypeLeft,
    FlowLayoutTypeCenter,
    FlowLayoutTypeRight
};

NS_ASSUME_NONNULL_BEGIN

@interface YHCustomCollectionViewFlowLayout : UICollectionViewFlowLayout

/** 两个Cell之间的距离  */
@property (assign, nonatomic) CGFloat betweenOfCell;

/** cell对齐方式  */
@property (assign, nonatomic) FlowLayoutType LayoutType;

- (instancetype)initWthType:(FlowLayoutType)LayoutType;

@end

NS_ASSUME_NONNULL_END
