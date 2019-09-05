//
//  MBProgressHUD+YHProgressHUD.m
//  MyProject
//
//  Created by LYH on 2019/8/1.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "MBProgressHUD+YHProgressHUD.h"

@implementation MBProgressHUD (YHProgressHUD)

#pragma mark - 带图片的显示

+ (void)show:(NSString *)text imageIcon:(NSString *)icon view:(UIView *)view {
    
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD *hud               = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode                         = MBProgressHUDModeCustomView;
    hud.detailsLabel.text            = text;
    hud.detailsLabel.textColor       = [UIColor whiteColor];
    hud.detailsLabel.font            = [UIFont systemFontOfSize:15 weight:UIFontWeightBold];
    hud.detailsLabel.textAlignment   = NSTextAlignmentCenter;
    hud.customView                   = [[UIImageView alloc ] initWithImage:[UIImage imageNamed:icon]];
    hud.bezelView.layer.cornerRadius = 8.0f;
    hud.bezelView.backgroundColor    = [[UIColor blackColor] colorWithAlphaComponent:.3];
    hud.animationType                = MBProgressHUDAnimationZoomOut;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide    = YES;
    
    // 1秒之后再消失
    [hud hideAnimated:YES afterDelay:1.5];
}


+ (void)showSuccess:(NSString *)successStr showView:(UIView *)view imageName:(NSString *)imageName {
    [self show:successStr imageIcon:@"successful" view:view];
}

+ (void)showError:(NSString *)errorStr showView:(UIView *)view imageName:(NSString *)imageName {
    [self show:errorStr imageIcon:@"delete_big" view:view];
}

+ (void)showError:(NSString *)errorStr showView:(UIView *)view{
    [self showError:errorStr showView:view imageName:@""];
}

+ (void)showSuccess:(NSString *)successStr showView:(UIView *)view{
    [self showSuccess:successStr showView:view imageName:@""];
}


#pragma mark - 纯文本提示
+ (void)displayTest:(NSString *)text color:(UIColor *)textColor font:(CGFloat)font view:(UIView *)view {
    
    MBProgressHUD *hud               = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode                         = MBProgressHUDModeText;
    hud.detailsLabel.text            = text;
    hud.detailsLabel.textColor       = textColor;
    hud.detailsLabel.font            = [UIFont systemFontOfSize:font weight:UIFontWeightRegular];
    hud.detailsLabel.textAlignment   = NSTextAlignmentCenter;
    hud.bezelView.layer.cornerRadius = 3.0f;
    hud.bezelView.backgroundColor    = [UIColor blackColor];
     // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide    = YES;
    [hud hideAnimated:YES afterDelay:1.5];
}

+ (void)display:(NSString *)text textColor:(UIColor *)textColor font:(CGFloat)font view:(UIView *)view {
    [self displayTest:text color:[UIColor whiteColor] font:15 view:view];
}

+ (void)showMessage:(NSString *)messageStr showView:(UIView *)view {
    [self display:messageStr textColor:[UIColor clearColor] font:0 view:view];
}

+ (void)showMessage:(NSString *)messageStr title:(NSString *)title showView:(UIView *)view {
    
    MBProgressHUD *hud               = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode                         = MBProgressHUDModeText;
    hud.label.text                   = title;
    hud.label.textColor              = [UIColor whiteColor];
    hud.label.font                   = [UIFont systemFontOfSize:15];
    hud.detailsLabel.text            = messageStr;
    hud.detailsLabel.font            = [UIFont systemFontOfSize:13];
    hud.detailsLabel.textColor       = [UIColor whiteColor];
    hud.bezelView.layer.cornerRadius = 5.0f;
    hud.bezelView.backgroundColor    = [UIColor blackColor];
    hud.userInteractionEnabled       = NO;
    [hud hideAnimated:YES afterDelay:1.5f];
}

@end
