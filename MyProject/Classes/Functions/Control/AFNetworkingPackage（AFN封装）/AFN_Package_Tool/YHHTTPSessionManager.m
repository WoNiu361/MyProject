//
//  YHHTTPSessionManager.m
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/10.
//  Copyright © 2019 LYH. All rights reserved.
//

#import "YHHTTPSessionManager.h"

@implementation YHHTTPSessionManager

+ (instancetype)shareInstance {
    
    static YHHTTPSessionManager *sessionShareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuartion = [NSURLSessionConfiguration defaultSessionConfiguration];
        configuartion.timeoutIntervalForRequest = 15;//请求超时时间
        sessionShareInstance = [[YHHTTPSessionManager alloc] initWithSessionConfiguration:configuartion];
//        sessionShareInstance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",@"charset=UTF-8",nil];
//        [sessionShareInstance.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        sessionShareInstance.requestSerializer = [AFJSONRequestSerializer serializer];
//        sessionShareInstance.responseSerializer = [AFHTTPResponseSerializer serializer];
//        [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    });
    return sessionShareInstance;
}


@end



@interface YHSystempParameterConfi ()
/**   应用名称   */
@property (nonatomic, copy, readwrite) NSString *appName;
/**   设备名称   */
@property (nonatomic, copy, readwrite) NSString *deviceName;
/**   系统名称   */
@property (nonatomic, copy, readwrite) NSString *osName;
/**   系统版本   */
@property (nonatomic, copy, readwrite) NSString *osVersion;
/**   Bundle版本   */
@property (nonatomic, copy, readwrite) NSString *bundleVersion;
/**   请求来源，值都是@"mobile"   */
@property (nonatomic, copy, readwrite) NSString *appClientID;
/**   操作系统类型   */
@property (nonatomic, copy, readwrite) NSString *deviceModel;
/**   设备ID   */
@property (nonatomic, copy, readwrite) NSString *deviceID;
@end


@implementation YHSystempParameterConfi

+ (instancetype)sharedInstance {
    
    static YHSystempParameterConfi *confi = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        confi = [[YHSystempParameterConfi alloc] init];
    });
    return confi;
}

- (instancetype)init {
    if (self = [super init]) {
        self.channelID     = @"AppStore";
        self.appName       = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]; // e.g. "AFNetworkingPackage"
        self.deviceName    = [[UIDevice currentDevice] name]; // e.g. "My iPhone"
        self.osName        = [[UIDevice currentDevice] systemName]; // @"iOS";
        self.osVersion     = [[UIDevice currentDevice] systemVersion]; // e.g. @"4.0"
        self.bundleVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];//e.g. version版本号
        self.appClientID   = @"mobile";
        self.deviceModel   = [[UIDevice currentDevice] model]; // e.g. @"iPhone", @"iPod touch"
        self.deviceID      = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    }
    return self;
}

@end
