//
//  UIView+Extension.m
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

// Retrieve and set the origin
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)aPoint{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}

- (CGPoint)origin {
    return self.frame.origin;
}

// Query other frame locations
- (CGPoint)bottomRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)bottomLeft {
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint)topRight {
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)newtop {
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)newleft {
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)newbottom {
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)newright {
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}



+ (UIView *)viewWithBackgroundColor:(UIColor *)bgColor
                              frame:(CGRect)frame {
    
    UIView *vi = [[UIView alloc]initWithFrame:frame];
    vi.backgroundColor = bgColor;
    return vi;
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width {
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
    self.layer.allowsEdgeAntialiasing = YES;
}

- (void)setCornerRadius:(CGFloat)radius {
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:radius];
}

+ (UIView *)viewWithBackgroundColor:(UIColor *)bgColor
                       cornerRadius:(CGFloat)cornerRadius
                        borderWidth:(CGFloat)borderWidth
                        borderColor:(UIColor *)borderColor
                              frame:(CGRect)frame {
    
    UIView *vi = [UIView viewWithBackgroundColor:bgColor frame:frame];
    vi.layer.cornerRadius = cornerRadius;
    vi.layer.borderWidth = borderWidth;
    vi.layer.borderColor = borderColor.CGColor;
    vi.layer.masksToBounds = YES;
    return vi;
}

- (void)wx_addCorner:(UIRectCorner)corner cornerRadius:(CGFloat)cornerRadius{
    
    NSCAssert(self.bounds.size.width != 0 && self.bounds.size.height != 0, @"必须得到目标View的实际bounds");
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

- (void)wx_shadow:(UIView *)view {
    
    view.backgroundColor = [UIColor whiteColor];
    view.layer.shadowColor = [[UIColor colorFromHexCode:@"000000"] colorWithAlphaComponent:0.5].CGColor;
    view.layer.shadowOpacity = 0.2;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    view.layer.shadowRadius = 2;
    view.layer.cornerRadius = 5;
}

+ (UIColor*)randomColor {
    
    UIColor * randomColor= [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
    
    return randomColor;
}

@end
