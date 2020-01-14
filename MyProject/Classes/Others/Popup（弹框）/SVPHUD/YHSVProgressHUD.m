//
//  YHSVProgressHUD.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "YHSVProgressHUD.h"
#import "SVProgressHUD.h"

@implementation YHSVProgressHUD

+ (void)initialize{
    
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD setCornerRadius:5];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightRegular]];
    [SVProgressHUD setMinimumSize:CGSizeMake(100, 0)];
    [SVProgressHUD setImageViewSize:CGSizeMake(23, 23)];
    [SVProgressHUD setRingThickness:1.0];
    [SVProgressHUD setRingNoTextRadius:20];
    [SVProgressHUD setRingRadius:15];
    

}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonnull"
+ (void)showMessageText:(NSString *)text{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showImage:nil status:text];
}
#pragma clang diagnostic pop

//遮盖，只用于详情现实，背景我给了个白色
+ (void)showLoadingWithStatus:(NSString *)status{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setBackgroundLayerColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:status];
}

+ (void)displayLoadingWithStatus:(NSString *)status {
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showWithStatus:status];
}

+ (void)showSuccessWithStatus:(NSString *)status{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showSuccessWithStatus:status];
}
+ (void)showErrorWithStatus:(NSString *)status{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showErrorWithStatus:status];
}

+ (void)showInfoWithStatus:(NSString *)status{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD showInfoWithStatus:status];
}

+ (void)dismiss {
    
    [SVProgressHUD dismiss];
}

@end
