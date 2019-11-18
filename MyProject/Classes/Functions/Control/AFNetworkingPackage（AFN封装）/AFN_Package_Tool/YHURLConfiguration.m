//
//  YHURLConfiguration.m
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/10.
//  Copyright © 2019 LYH. All rights reserved.
//

#import "YHURLConfiguration.h"

@interface YHURLConfiguration ()
/**   网络请求的地址，通过environmentType设置   */
@property (nonatomic, copy, readwrite) NSString * baseRequestURL;
/**   H5Host   */
@property (nonatomic, copy, readwrite) NSString * baseH5URL;
@end

@implementation YHURLConfiguration

- (instancetype)init {
    if (self = [super init]) {
        self.environmentType = YHDevelopEnvironmentRelease;
    }
    return self;
}

+ (instancetype)shareConfigurate {
    
    static YHURLConfiguration *configurate = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        configurate = [[YHURLConfiguration alloc] init];
    });
    return configurate;
}

-(void)setEnvironmentType:(YHDevelopEnvironmentType)environmentType {
    
    _environmentType = environmentType;
    switch (environmentType) {
        case YHDevelopEnvironmentRelease: {//发布环境
            self.baseRequestURL = @"";
            self.baseH5URL = @"";
        }
            break;
            
        case YHDevelopEnvironmentDebug: {//测试环境
            self.baseRequestURL = @"";
            self.baseH5URL = @"";
        }
            break;
            
        case YHDevelopEnvironmentDevelopment: {//开发环境
            self.baseRequestURL = @"";
            self.baseH5URL = @"";
        }
            break;
            
        case YHDevelopEnvironmentPreRelease: {//预发布环境
            
        }
            break;
            
        default: {//发布环境
            self.baseRequestURL = @"";
            self.baseH5URL = @"";
        }
            break;
    }
}

@end
