//
//  YHBaseView.h
//  MyProject
//
//  Created by 吕颜辉 on 2018/2/12.
//  Copyright © 2018 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHBaseView : UIView

/**
 *  从nib文件中获取view
 */
+ (instancetype)viewFromNib;

+ (instancetype)viewFromNibWithIndex:(NSInteger)index;

/**   是否改变view的frame,默认为NO    */
@property (nonatomic, assign) BOOL changeFrame;

@end

NS_ASSUME_NONNULL_END
