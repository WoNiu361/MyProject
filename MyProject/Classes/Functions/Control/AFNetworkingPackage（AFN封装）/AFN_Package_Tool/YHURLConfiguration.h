//
//  YHURLConfiguration.h
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/10.
//  Copyright © 2019 LYH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,YHDevelopEnvironmentType) {
    YHDevelopEnvironmentRelease            = 0,  //发布环境
    YHDevelopEnvironmentDebug,                   //测试环境
    YHDevelopEnvironmentDevelopment,             //开发环境
    YHDevelopEnvironmentPreRelease,              //预发布环境
};

NS_ASSUME_NONNULL_BEGIN

@interface YHURLConfiguration : NSObject

/**   网络请求的环境类型（默认为生产环境）    */
@property (nonatomic, assign) YHDevelopEnvironmentType environmentType;
/**   网络请求的地址，通过environmentType设置   */
@property (nonatomic, copy, readonly) NSString *baseRequestURL;
/**   H5Host   */
@property (nonatomic, copy, readonly) NSString *baseH5URL;

/**
 *  单例模式
 *
 *  @return 实例化对象
 */
+ (instancetype)shareConfigurate;
@end

NS_ASSUME_NONNULL_END
