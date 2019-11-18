//
//  YHHttpRequestTool.h
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/11.
//  Copyright © 2019 LYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHHttpRequest.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHHttpRequestTool : NSObject

/**
 开始一个网络请求任务
 
 @param params 参数
 @param path   URL路径
 @param type   请求类型
 @param coverType  遮盖类型
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)startTaskWithParams:(NSDictionary *)params
                       path:(NSString *)path
                     method:(YHHttpRequestType)type
                  coverType:(CoverAlertType)coverType
               successBlock:(YHRequestFinishedBlock)successBlock
               failureBlock:(YHRequestFinishedBlock)failureBlock;

/**
 取消所有网络任务
 */
- (void)cancelTask;

@end

NS_ASSUME_NONNULL_END
