//
//  YHAccountTool.h
//  MyProject
//
//  Created by LYH on 2019/10/21.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHAccount.h"
#import "Singleton.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHAccountTool : NSObject
single_interface(YHAccountTool)

/**  保存用户信息   */
- (void)saveAccountInfo:(YHAccount *)account;

/**  删除用户信息   */
- (void)removeAccount;

/**    获取当前用户信息   */
@property (nonatomic, strong) YHAccount *account;

@end

/**
 用法
 NSString *nickName = [HRAccountTool sharedHRAccountTool].nickName;
 */

NS_ASSUME_NONNULL_END
