//
//  UIView+Extension.h
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;
@property (readonly) CGPoint bottomLeft;
@property (readonly) CGPoint bottomRight;
@property (readonly) CGPoint topRight;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat left;

@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat right;



/**
 设置view的背景色
 
 @param bgColor 背景颜色
 @param frame 位置和大小
 @return 返回view
 */
+ (UIView *)viewWithBackgroundColor:(UIColor *)bgColor
                               frame:(CGRect)frame;

/**
 设置view的圆角
 
 @param radius 圆角半径
 */
- (void)setCornerRadius:(CGFloat)radius;

/**
 设置边框
 
 @param color 颜色
 @param width 边框宽度
 */
- (void)setBorderColor:(UIColor *)color
                 width:(CGFloat)width;

/**
 设置带圆角的view
 
 @param bgColor 背景色
 @param cornerRadius 圆角的大小
 @param borderWidth layer的宽度
 @param borderColor layer颜色
 @param frame 位置和大小
 @return 返回view
 */
+ (UIView *)viewWithBackgroundColor:(UIColor *)bgColor
                            cornerRadius:(CGFloat)cornerRadius
                             borderWidth:(CGFloat)borderWidth
                             borderColor:(UIColor *)borderColor
                                   frame:(CGRect)frame;

/**
 给View添加圆角，用于少量圆角显示。

 @param corner 圆角方向
 @param cornerRadius 圆角
 */
- (void)wx_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius;

/**
给View添加阴影。
*/
- (void)wx_shadow:(UIView *)view;

+ (UIColor*)randomColor;
@end
