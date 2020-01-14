//
//  UIImageView+YHImageView.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "UIImageView+YHImageView.h"

@implementation UIImageView (YHImageView)

+ (UIImageView *)imageViewWithImage:(NSString *)image frame:(CGRect)frame {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imageNamed:image];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = true;
    imageView.contentScaleFactor = [UIScreen mainScreen].scale;
    return imageView;
}

@end
