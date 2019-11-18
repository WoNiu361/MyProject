//
//  YHResponseResult.h
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/10.
//  Copyright © 2019 LYH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 一般数据请求结果类
 */
@interface YHResponseResult : NSObject
/**   Response Header   */
@property (nonatomic, strong) NSDictionary *responseHeaderFields;
/**   请求操作相应码   */
@property (nonatomic, assign) NSInteger    errorCode;
/**   服务端返回的数据   */
@property (nonatomic, strong) NSDictionary *responseContent;
/**   请求失败的内容描述   */
@property (nonatomic, copy) NSString       *failResponseDesc;
/**   服务端返回的未知类型的数据（为适配特殊情况下后台发疯时返回的数据）   */
@property (nonatomic, strong) id         resonse;

/**
 初始化
 
 @param responseObject 数据源
 @return THResult实例
 */
+ (instancetype)resultFromResponseObject:(NSDictionary *)responseObject;

/**
 * 是否请求成功
 */
- (BOOL)success;
@end


/**
 用来封装文件数据的模型,例如：上传图片
 */
@interface YHFormData : NSObject

/**   文件数据   */
@property (nonatomic, strong) NSData *data;

/**    参数名   */
@property (nonatomic, copy) NSString *name;

/**   文件名   */
@property (nonatomic, copy) NSString *filename;

/**   文件类型（eg：image/jpeg）   */
@property (nonatomic, copy) NSString *mimeType;

@end

NS_ASSUME_NONNULL_END
