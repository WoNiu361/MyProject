//
//  YHDrawLineView.m
//  MyProject
//
//  Created by LYH on 2019/7/30.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHDrawLineView.h"

@implementation YHDrawLineView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MainScreenWidth/3, 0, MainScreenWidth/3, 30)];
        [self addSubview:label];
        label.text = @"使用第三方登录";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.textColor = kUIColorFromHEX(0x878787);
    }
    return self;
}

//继承与UIView的类，只要你写了下面这个方法，就会自动调用这个方法
- (void)drawRect:(CGRect)rect{//初次不建议使用，位置很难把握，浪费时间
    CGContextRef context = UIGraphicsGetCurrentContext();
    //第二个参数决定线的x位置，三参是y的位置
    CGContextMoveToPoint(context, 15, 15);
    //第二个参数决定线的宽度，三参是y的位置
    CGContextAddLineToPoint(context, MainScreenWidth/3 , 15);
    [kUIColorFromHEX(0x878787) set];
    CGContextSetLineWidth(context, 0.5);//二参是线的高度
    CGContextStrokePath(context);
    
    CGContextRef context1 = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(context1, 2 * MainScreenWidth/3, 15);
    CGContextAddLineToPoint(context1, MainScreenWidth -15, 15);
    [kUIColorFromHEX(0x878787) set];
    CGContextSetLineWidth(context1, 0.5);
    CGContextStrokePath(context1);
}

@end





@implementation YHDrawHorizontalImaginaryLineView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    [self drawDashLine:self lineLength:6 lineSpacing:3 lineColor:[UIColor redColor]];
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
- (void)drawDashLine:(UIView *)lineView
          lineLength:(int)lineLength
         lineSpacing:(int)lineSpacing
           lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

@end





@interface YHDrawVerticalImaginaryLineView () {
    NSInteger _lineHeight;
}

@end

@implementation YHDrawVerticalImaginaryLineView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        _lineHeight = frame.size.height;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,5);//虚线的宽度
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGFloat lengths[] = {_lineLength,_lineSpacing};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0,_lineHeight);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

-(void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}

- (void)setLineSpacing:(NSInteger)lineSpacing {
    _lineSpacing = lineSpacing;
}

-(void)setLineLength:(NSInteger)lineLength {
    _lineLength = lineLength;
}

@end




@interface YHVerticalImaginaryLineView () {
    NSInteger _lineLength;  //线宽
    NSInteger _lineSpacing; //虚心间隔
    UIColor *_lineColor;    //虚线颜色
    NSInteger _lineHeight;   //虚线高度
}

@end

@implementation YHVerticalImaginaryLineView

- (instancetype)initWithFrame:(CGRect)frame
                   lineLength:(NSInteger)lineLength
                  lineSpacing:(NSInteger)lineSpacing
                    lineColor:(UIColor *)lineColor {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _lineColor = lineColor;
        _lineHeight = self.height;
        _lineSpacing = lineSpacing;
        _lineLength = lineLength;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextSetLineWidth(context,5);
    CGContextSetStrokeColorWithColor(context, _lineColor.CGColor);
    CGFloat lengths[] = {_lineLength,_lineSpacing};
    CGContextSetLineDash(context, 0, lengths,2);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0,_lineHeight);
    CGContextStrokePath(context);
    CGContextClosePath(context);
}

@end
