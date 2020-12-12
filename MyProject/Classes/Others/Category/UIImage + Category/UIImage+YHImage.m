//
//  UIImage+YHImage.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/9/9.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "UIImage+YHImage.h"
#import <Accelerate/Accelerate.h>


#define kScreenScale ([UIScreen mainScreen].scale)

static CGFloat edgeSizeFromCornerRadius(CGFloat cornerRadius) {
    return cornerRadius * 2 + 1;
}


@implementation UIImage (YHImage)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
/**
 根据颜色生成图片

 @param color 颜色
 @param size 图片大小
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    
    return [self imageWithColor:color size:size alpha:1.0];
}

+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect {
    
    if (!colors.count || CGRectEqualToRect(rect, CGRectZero)) {
        return nil;
        
    }
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = rect;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    NSMutableArray *mutColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors) {
        [mutColors addObject:(__bridge id)color.CGColor];
        
    }
    gradientLayer.colors = [NSArray arrayWithArray:mutColors];
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.opaque, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+ (UIImage *)gradientGlobalImageWithrect:(CGRect)rect{
    
    return [self gradientImageWithColors:@[kRGBColor(254, 208, 0),kRGBColor(254, 189, 0)] rect:rect];
}


/**
 根据颜色生成 1x1 point 图片

 @param color 颜色
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color {
    return [self imageWithColor:color size:CGSizeMake(1.f, 1.f)];
}

/**
 根据UIColor和cornerRadius生成圆角的UIImage

 @param color 颜色
 @param cornerRadius 圆角半径
 @return 图片
 */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "Wnonnull"
+ (UIImage *)imageWithColor:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
    
    return [self imageWithColor:color
                   cornerRadius:cornerRadius
                    borderWidth:0
                    borderColor:nil];
}
#pragma clang diagnostic pop


/**
 根据UIColor和cornerRadius生成带边框及圆角的UIImage
 
 @param color 生成图片的颜色
 @param cornerRadius 圆角的半径
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return 生成的UIImage对象
 */
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius
                borderWidth:(CGFloat)borderWidth
                borderColor:(UIColor *)borderColor{
    
    return [self imageWithColor:color
                   cornerRadius:cornerRadius
                        corners:UIRectCornerAllCorners
                    borderWidth:borderWidth
                    borderColor:borderColor
                 borderLineJoin:kCGLineJoinMiter];
}


/**
 根据颜色生成带圆角、边框的图片

 @param color 颜色
 @param cornerRadius 圆角半径
 @param borderWidth 圆角边框
 @param borderColor 边框颜色
 @param borderLineJoin 线条交叉类型
 @return 图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color
               cornerRadius:(CGFloat)cornerRadius
                    corners:(UIRectCorner)corners
                borderWidth:(CGFloat)borderWidth
                borderColor:(UIColor *)borderColor
                borderLineJoin:(CGLineJoin)borderLineJoin{
    
    CGFloat minEdgeSize = edgeSizeFromCornerRadius(cornerRadius);
    CGRect rect = CGRectMake(0, 0, minEdgeSize, minEdgeSize);
    UIImage *image = [UIImage imageWithColor:color];
    
    if (corners != UIRectCornerAllCorners) {
        UIRectCorner tmp = 0;
        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
        corners = tmp;
    }
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -rect.size.height);
    
    CGFloat minSize = MIN(rect.size.width, rect.size.height);
    if (borderWidth < minSize / 2) {
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, borderWidth)];
        [path closePath];
        
        CGContextSaveGState(context);
        [path addClip];
        CGContextDrawImage(context, rect, image.CGImage);
        CGContextRestoreGState(context);
    }
    
    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
        CGFloat strokeInset = (floor(borderWidth * image.scale) + 0.5) / image.scale;
        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
        CGFloat strokeRadius = cornerRadius > image.scale / 2 ? cornerRadius - image.scale / 2 : 0;
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius, borderWidth)];
        [path closePath];
        
        path.lineWidth = borderWidth;
        path.lineJoinStyle = borderLineJoin;
        [borderColor setStroke];
        [path stroke];
    }
    
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [targetImage resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, cornerRadius, cornerRadius, cornerRadius)];
}

/**
 生成带圆环边框的image
 
 @param name imageName
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return image
 */
+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    return  [self circleImageWithImage:[UIImage imageNamed:name] borderWidth:borderWidth borderColor:borderColor];
}

/**
 生成带圆环边框的image
 
 @param image image
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @return image
 */
+ (UIImage *)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    // 1.加载原图
    UIImage *oldImage = image;
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

/**
 根据文字生成标签
 
 @param str 文字
 @param BgColor 背景颜色
 @param font 字体大小
 @param textColor 文字颜色
 @param bgImage 背景图片
 @param corner 圆角
 @return image
 */
+ (UIImage *)createFlagIamgeWithStr:(NSString *)str withBgColor:(UIColor *)BgColor image:(UIImage *)bgImage withFont:(UIFont *)font withTextColor:(UIColor *)textColor corner:(CGFloat)corner{
    
    CGSize size = [str sizehWithFont:font maxSize:CGSizeMake(MainScreenWidth, font.lineHeight)];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    if (bgImage) {
        imageView.image = bgImage;
    }
    if (BgColor) {
        imageView.backgroundColor = BgColor;
    }
    imageView.frame = CGRectMake(0, 0, size.width+10, size.height);
    
    UILabel *tagL = [UILabel new];
    tagL.frame = imageView.bounds;
    tagL.text = str;
    tagL.font = font;
    tagL.textColor = textColor;
    tagL.textAlignment = NSTextAlignmentCenter;
    
    [imageView addSubview:tagL];
    
    if (corner) {
        imageView.clipsToBounds = YES;
        imageView.layer.cornerRadius = corner;
    }
    
    UIImage *image = [self captureWithView:imageView];
    return image;
}


/**
 根据文字生成图片
 
 @param str 文字
 @param image 背景图片
 @param fontSize 字体大小
 @param textColor 文字颜色
 @return image
 */
+ (UIImage *)createOtherMerchantImageWithStr:(NSString *)str withBgImage:(UIImage *)image withFont:(CGFloat)fontSize withTextColor:(UIColor *)textColor
{
    
    CGSize size= CGSizeMake(image.size.width,image.size.height ); // 画布大小
    UIGraphicsBeginImageContextWithOptions (size,NO,0.0 );
    [image drawAtPoint:CGPointMake(0,0)];
    
    // 获得一个位图图形上下文
    CGContextRef context= UIGraphicsGetCurrentContext ();
    CGContextDrawPath (context, kCGPathStroke);
    
    //画自己想画的内容。。。。。
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *font = [UIFont fontWithName:(@"PingFangSC-Regular") size:fontSize];
    //计算文字的宽度和高度：支持多行显示
    CGSize sizeText = [str boundingRectWithSize:size
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:font}
                                        context:nil].size;
    
    //为了能够垂直居中，需要计算显示起点坐标x,y
    CGRect rect = CGRectMake((size.width-sizeText.width)/2, (size.height-sizeText.height)/2, sizeText.width, sizeText.height);
    
    [str drawInRect:rect withAttributes:@{ NSFontAttributeName:font, NSForegroundColorAttributeName :textColor,NSParagraphStyleAttributeName:paragraphStyle}];
    
    // 返回绘制的新图形
    UIImage *newImage= UIGraphicsGetImageFromCurrentImageContext ();
    UIGraphicsEndImageContext ();
    return newImage;
    
}

#pragma mark 生成返回按钮图片
+ (UIImage *)backButtonImageWithColor:(UIColor *)color barMetrics:(UIBarMetrics)metrics cornerRadius:(CGFloat)cornerRadius{
    
    CGSize size;
    
    if (metrics == UIBarMetricsDefault)
    {
        size = CGSizeMake(50, 30);
        
    } else {
        
        size = CGSizeMake(60, 23);
    }
    
    UIBezierPath * path = [self bezierPathForBackButtonInRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:cornerRadius];
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    [color setFill];
    [path addClip];
    [path fill];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(cornerRadius, 15, cornerRadius, cornerRadius)];
}


#pragma mark 生成毛玻璃效果的图片
- (UIImage *)imageWithBlur{
    
    return [self imageWithalpha:0.1 radius:10 colorSaturationFactor:1];
}


#pragma mark 生成自定义毛玻璃效果的图片
- (UIImage *)imageWithalpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor{
    
    UIColor * tintColor = [UIColor colorWithWhite:1.0 alpha:alpha];
    return [self imageBluredWithRadius:radius tintColor:tintColor saturationDeltaFactor:colorSaturationFactor maskImage:nil];
}

#pragma mark 由目标view生成图片
+ (UIImage *)captureWithView:(UIView *)view{
    //为了除去生成图片下边白色线条 height-1个点
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(view.frame.size.width, view.frame.size.height), NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 截屏
+ (UIImage *)screenshots
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(MainScreenWidth * kScreenScale, MainScreenHeight * kScreenScale), YES, 0);
    [[[[UIApplication sharedApplication] keyWindow] layer] renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = viewImage.CGImage;
    CGRect rect = CGRectMake(0, 0, MainScreenWidth * kScreenScale, MainScreenHeight * kScreenScale);
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *sendImage = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    return sendImage;
}


#pragma mark 根据maxImagePix设定的图片最大显示像素压缩图片
- (UIImage *)compressedImage:(float)maxImagePix
{
    if (maxImagePix < 0 || maxImagePix > 1000.0)
    {
        maxImagePix = 600.0;
    }
    
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    if (width <= maxImagePix && height <= maxImagePix)
    {
        // 无需压缩
        return self;
    }
    
    if (width == 0 || height == 0)
    {
        // void zero exception
        return self;
    }
    
    UIImage * newImage = nil;
    
    
    CGFloat widthFactor = maxImagePix / width;
    CGFloat heightFactor = maxImagePix / height;
    CGFloat scaleFactor = 0.0;
    
    if (widthFactor > heightFactor)
        scaleFactor = heightFactor; // scale to fit height
    else
        scaleFactor = widthFactor; // scale to fit width
    
    // 等比例缩放
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    
    CGSize targetSize = CGSizeMake(scaledWidth, scaledHeight);
    
    // 重绘图片
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark 压缩至指定字节的图片
- (NSData *)compressedDataWithMaxLengh:(NSInteger)maxLength
{
    NSAssert(maxLength > 0, @"图片的大小必须大于0");
    CGFloat compress = 1.0f;
    NSData *data = UIImageJPEGRepresentation(self, compress);
    while (data.length > maxLength && compress > 0.1) {
        compress -= 0.1f;
        data = UIImageJPEGRepresentation(self, compress);
    }
    return data;
}


+ (UIBezierPath *) bezierPathForBackButtonInRect:(CGRect)rect cornerRadius:(CGFloat)radius
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint mPoint = CGPointMake(CGRectGetMaxX(rect) - radius, rect.origin.y);
    CGPoint ctrlPoint = mPoint;
    [path moveToPoint:mPoint];
    
    ctrlPoint.y += radius;
    mPoint.x += radius;
    mPoint.y += radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:(float)M_PI + (float)M_PI_2 endAngle:0 clockwise:YES];
    
    mPoint.y = CGRectGetMaxY(rect) - radius;
    [path addLineToPoint:mPoint];
    
    ctrlPoint = mPoint;
    mPoint.y += radius;
    mPoint.x -= radius;
    ctrlPoint.x -= radius;
    if (radius > 0) [path addArcWithCenter:ctrlPoint radius:radius startAngle:0 endAngle:(float)M_PI_2 clockwise:YES];
    
    mPoint.x = rect.origin.x + (10.0f);
    [path addLineToPoint:mPoint];
    
    [path addLineToPoint:CGPointMake(rect.origin.x, CGRectGetMidY(rect))];
    
    mPoint.y = rect.origin.y;
    [path addLineToPoint:mPoint];
    
    [path closePath];
    return path;
}



// 内部方法,核心代码,封装了毛玻璃效果 参数:半径,颜色,色彩饱和度
- (UIImage *)imageBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage
{
    
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            
            unsigned int radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, radius, radius, 0, kvImageEdgeExtend);
        }
        
        BOOL effectImageBuffersAreSwapped = NO;
        
        if (hasSaturationChange) {
            
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            
            if (hasBlur) {
                
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
                
            } else {
                
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        
        
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    // 开启上下文 用于输出图像
    UIGraphicsBeginImageContextWithOptions(self.size, NO, kScreenScale);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // 开始画底图
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // 开始画模糊效果
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // 添加颜色渲染
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // 输出成品,并关闭上下文
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}

#pragma mark - 根据图片数组生成从左往右的图片部分重叠合成图
+ (UIImage *)overlapImageWithSize:(CGSize)size imageArray:(NSArray *)array {
    
    if (!array || !array.count) {
        return [UIImage new];
    }
    
    CGFloat width = size.height;//内部重叠图默认宽高相同
    NSUInteger count = array.count;//图片张数
    
    CGFloat margin;//重叠部分宽度
    if ((width * count - size.width) > 0 && count > 1) {
        margin = (width * count - size.width)/(count-1);
    }else {
        margin = 0;
    }
    
    UIImage *image;
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    for (int i = 0; i < count; i++) {
        CGContextSaveGState(ctx);
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(i * (width-margin), 0, width, width) cornerRadius:width/2];
        CGContextAddPath(ctx, path.CGPath);
        CGContextClip(ctx);
        
        UIImage *orininalImage = array[i];
        [orininalImage drawInRect:CGRectMake(i * (width-margin), 0, width, width)];
        
        CGContextRestoreGState(ctx);
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 创建二维码/条形码
+ (UIImage*)createQRImageWithString:(NSString*)content QRSize:(CGSize)size
{
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    CIImage *qrImage = qrFilter.outputImage;
    //绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

+ (UIImage* )createQRImageWithString:(NSString*)content QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor
{
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    //生成
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",qrFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:qrColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:bkColor.CGColor],
                             nil];
    CIImage *qrImage = colorFilter.outputImage;
    //绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}

+ (UIImage *)createBarCodeImageWithString:(NSString *)content barSize:(CGSize)size
{
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *qrImage = filter.outputImage;
    //绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}


+ (UIImage* )createBarCodeImageWithString:(NSString*)content QRSize:(CGSize)size QRColor:(UIColor*)qrColor bkColor:(UIColor*)bkColor
{
    NSData *stringData = [content dataUsingEncoding: NSUTF8StringEncoding];
    //生成
    CIFilter *barFilter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [barFilter setValue:stringData forKey:@"inputMessage"];
    
    //上色
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"
                                       keysAndValues:
                             @"inputImage",barFilter.outputImage,
                             @"inputColor0",[CIColor colorWithCGColor:qrColor.CGColor],
                             @"inputColor1",[CIColor colorWithCGColor:bkColor.CGColor],
                             nil];
    
    CIImage *qrImage = colorFilter.outputImage;
    //绘制
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGImageRelease(cgImage);
    
    return codeImage;
}


@end
