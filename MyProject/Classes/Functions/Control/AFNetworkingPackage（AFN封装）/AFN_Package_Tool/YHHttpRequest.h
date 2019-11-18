//
//  YHHttpRequest.h
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/10.
//  Copyright © 2019 LYH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YHResponseResult.h"
#import "AFNetworking.h"
#import "YHResponseResult.h"

/**   请求类型：GET,POST, 上传  */
typedef NS_ENUM(NSInteger,YHHttpRequestType) {
    YHHttpRequestGet            = 0,  //get请求
    YHHttpRequestPost,                //post请求
    YHHttpRequestPostUpload,          //上传
};

/**   遮盖类型   */
typedef NS_ENUM(NSInteger,CoverAlertType) {
    CoverAlertType_None,
    CoverAlertType_Toast,
    CoverAlertType_Alert,
};

/**   状态值   */
typedef NS_ENUM(NSInteger, YHStatusCodeType) {
    YHStatusCodeTypeRequsetSuccess = 200,  // 请求成功
    YHStatusCodeTypeSessionTimeOut = -1001,// 请求超时
    YHStatusCodeTypeTokenError = 1117,     //token错误
};

typedef void (^YHRequestFinishedBlock)(YHResponseResult * _Nonnull result);

NS_ASSUME_NONNULL_BEGIN

@interface YHHttpRequest : NSObject
/**   当前正在执行的操作   */
@property (nonatomic, weak) NSURLSessionDataTask *task;
/**   HTTP请求的类型   */
@property (nonatomic, assign) YHHttpRequestType requestType;
/**   请求地址   */
@property (strong, nonatomic) NSString *requestPath;
/**   是否是原始值，用于特定请求，不需要解密数据。例如图片上传后的返回数据 默认为NO   */
@property (nonatomic, assign) BOOL isOriginalData;

/**
 发送请求
 
 @param params 参数
 @param successBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)startWithParams:(id)params successBlock:(YHRequestFinishedBlock)successBlock failureBlock:(YHRequestFinishedBlock)failureBlock;

/**
 取消当前正在执行的请求
 */
- (void)cancel;
@end

NS_ASSUME_NONNULL_END
