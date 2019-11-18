//
//  YHHTTPSessionManager.h
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/10.
//  Copyright © 2019 LYH. All rights reserved.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHHTTPSessionManager : AFHTTPSessionManager

+ (instancetype)shareInstance;

@end



#pragma mark - 一些系统的参数
@interface YHSystempParameterConfi : NSObject
/**   渠道号   */
@property (nonatomic, copy) NSString *channelID;
/**   应用名称   */
@property (nonatomic, copy, readonly) NSString *appName;
/**   设备名称   */
@property (nonatomic, copy, readonly) NSString *deviceName;
/**   系统名称   */
@property (nonatomic, copy, readonly) NSString *osName;
/**   系统版本   */
@property (nonatomic, copy, readonly) NSString *osVersion;
/**   Bundle版本   */
@property (nonatomic, copy, readonly) NSString *bundleVersion;
/**   请求来源，值都是@"mobile"   */
@property (nonatomic, copy, readonly) NSString *appClientID;
/**   操作系统类型   */
@property (nonatomic, copy, readonly) NSString *deviceModel;
/**   设备ID,这个ID是虚拟的，不是你手机真的identifier，不过也是唯一的   */
@property (nonatomic, copy, readonly) NSString *deviceID;

+ (instancetype)sharedInstance;
@end
NS_ASSUME_NONNULL_END
