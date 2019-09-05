//
//  YHDrawLineView.h
//  MyProject
//
//  Created by LYH on 2019/7/30.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHDrawLineView : UIView

@end


#pragma mark - 水平虚线
@interface YHDrawHorizontalImaginaryLineView : UIView

@end


#pragma mark - 竖直虚线
@interface YHDrawVerticalImaginaryLineView : UIView

/**    虚线宽度   */
@property (nonatomic, assign) NSInteger lineLength;
/**    虚线间隔   */
@property (nonatomic, assign) NSInteger lineSpacing;
/**    虚线颜色   */
@property (nonatomic, strong) UIColor *lineColor;
@end



@interface YHVerticalImaginaryLineView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                   lineLength:(NSInteger)lineLength
                  lineSpacing:(NSInteger)lineSpacing
                    lineColor:(UIColor *)lineColor;

@end
NS_ASSUME_NONNULL_END
