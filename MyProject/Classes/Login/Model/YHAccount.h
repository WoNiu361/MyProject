//
//  YHAccount.h
//  MyProject
//
//  Created by LYH on 2019/10/21.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHAccount : NSObject

/**    性别    */
@property (nonatomic, copy) NSString *sex;
/**    头像地址    */
@property (nonatomic, copy) NSString *avatarUrl;
/**    昵称    */
@property (nonatomic, copy) NSString *nickName;
/**    微信绑定状态 0=未绑定过，1=已绑定过   */
@property (nonatomic, assign) NSInteger bindState;


@end

NS_ASSUME_NONNULL_END
