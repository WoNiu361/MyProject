//
//  YHShareInstance.m
//  MyProject
//
//  Created by LYH on 2019/9/19.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHShareInstance.h"

@implementation YHShareInstance

+ (instancetype)shareInstance {
    
    static YHShareInstance *yhShareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        yhShareInstance = [[YHShareInstance alloc] init];
    });
    return yhShareInstance;
}

#pragma mark - 切圆角
- (CAShapeLayer *)masksToBoundsWithFrame:(CGRect)viewFrame
                              rectCorner:(UIRectCorner)rectCorner
                                    size:(CGSize)viewSize {
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:viewFrame byRoundingCorners:rectCorner cornerRadii:viewSize];
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.frame = viewFrame;
    shapeLayer.path = bezierPath.CGPath;
    return shapeLayer;
}

#pragma mark - 获取当前时间
- (NSString *)getCurrentTimeWithDateFormatter:(NSDateFormatter *)formatter {
    
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    return currentTime;
}

#pragma mark - 改变文字的颜色
- (NSMutableAttributedString *)changeColorWithColor:(UIColor *)color
                                           location:(NSInteger)location
                                              lenth:(NSInteger)lenth
                                               text:(NSString *)text {
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributeString addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(location, lenth)];
    return attributeString;
}

- (NSMutableAttributedString *)changeColorAndFontWithColor:(UIColor *)color
                                                  location:(NSInteger)location
                                                     lenth:(NSInteger)lenth
                                                      text:(NSString *)text
                                                      font:(UIFont *)font {
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributeString addAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font} range:NSMakeRange(location, lenth)];
    return attributeString;
}

#pragma mark - 判断字符串是否为空
- (BOOL)judgeStringWhetherBlank:(id)txt {
    if (txt == nil
        || txt == NULL
        || [[txt class] isSubclassOfClass:[NSNull class]]
        || [txt isEqualToString:@""]
        || [txt isEqualToString:@"null"]
        || [txt isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

#pragma mark - 处理空的字符串
- (NSString *)dealWithEmptyStringWithStr:(NSString *)str {
    
    NSString *dealStr = @"";
    if ([[YHShareInstance shareInstance] judgeStringWhetherBlank:str]) {
        dealStr = @"";
    } else {
        dealStr = str;
    }
    return dealStr;
}

#pragma mark - 比较俩个时间的大小
- (NSInteger)compareOneDay:(NSString *)oneDay
                anotherDay:(NSString *)anotherDay
             dateFormatter:(NSString *)formatter {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatter];//yyyy-MM-dd
    NSDate *dateA = [dateFormatter dateFromString:oneDay];
    NSDate *dateB = [dateFormatter dateFromString:anotherDay];
    NSComparisonResult result = [dateA compare:dateB];
    if (result == NSOrderedDescending) {
        NSLog(@"oneDay  is in the future");
        return 1;
    }  else if (result == NSOrderedAscending){
        NSLog(@"oneDay is in the past");
        return -1;
    }
    NSLog(@"Both dates are the same");
    return 0;
}

#pragma mark - 照片获取本地路径转换
- (NSString *)getImagePath:(UIImage *)Image {
    
    NSString *filePath = nil;
    NSData *data = nil;
    NSLog(@"luing 0-image---%@",Image);
    if (UIImagePNGRepresentation(Image) == nil) {
        data = UIImageJPEGRepresentation(Image, 1.0);
    } else {
        data = UIImagePNGRepresentation(Image);
    }
    // 这里将图片放在沙盒的documents文件夹中
    NSString *DocumentsPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    // 文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    // 把刚刚图片转换的data对象拷贝至沙盒中
    [fileManager createDirectoryAtPath:DocumentsPath withIntermediateDirectories:YES attributes:nil error:nil];
    NSString *ImagePath = [[NSString alloc] initWithFormat:@"/theFirstImage.png"];
    [fileManager createFileAtPath:[DocumentsPath stringByAppendingString:ImagePath] contents:data attributes:nil];
    
    // 得到选择后沙盒中图片的完整路径
    filePath = [[NSString alloc] initWithFormat:@"%@%@", DocumentsPath, ImagePath];
    return filePath;
}

#pragma mark - 压缩图片
- (NSData *)compressImage:(UIImage *)image {
    
    NSInteger maxFileSize = 700;
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.001f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    while (imageData.length/1024 > maxFileSize && compression > maxCompression) {
        compression -= 0.01;
        imageData = UIImageJPEGRepresentation(image, compression);
    }
    return imageData;
}
@end
