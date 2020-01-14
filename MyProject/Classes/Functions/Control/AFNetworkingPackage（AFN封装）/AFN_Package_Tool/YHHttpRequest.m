//
//  YHHttpRequest.m
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/10.
//  Copyright © 2019 LYH. All rights reserved.
//

#import "YHHttpRequest.h"
#import "YHHTTPSessionManager.h"
#import "YHURLConfiguration.h"
#import "ServiceConfigure.h"

@interface YHHttpRequest ()
/**   请求目标URL   */
@property (nonatomic, strong) NSString *requestUrl;

/**
 *  网络请求结束后请求结果的分析
 *
 *  @param params         传给服务端的参数
 *  @param task           NSURLSessionDataTask实例
 *  @param responseObject 服务端返回的数据
 *  @param error          网络请求失败的错误信息
 *  @param successBlock   接口获取数据成功的回调
 *  @param failureBlock   接口获取数据失败的回调
 */
- (void)requestFinishedWithParams:(NSDictionary *)params task:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error SuccessBlock:(YHRequestFinishedBlock)successBlock failureBlock:(YHRequestFinishedBlock)failureBlock;
@end

@implementation YHHttpRequest

+ (void)initialize {
    
    YHHTTPSessionManager *manager = [YHHTTPSessionManager shareInstance];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = true;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain",@"charset=UTF-8",nil];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
}

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)startWithParams:(id)params successBlock:(YHRequestFinishedBlock)successBlock failureBlock:(YHRequestFinishedBlock)failureBlock {
    if (self.task) {
        [self cancel];
    }
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    self.requestUrl = [[NSString stringWithFormat:@"%@%@",[[YHURLConfiguration shareConfigurate] baseRequestURL],self.requestPath] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    
    YHHTTPSessionManager *manager = [YHHTTPSessionManager shareInstance];
    [self configRequestSerializer:manager.requestSerializer];
    switch (self.requestType) {
        case YHHttpRequestGet: {
            self.task = [manager GET:self.requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self requestFinishedWithParams:params task:task responseObject:responseObject error:nil SuccessBlock:successBlock failureBlock:failureBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self requestFinishedWithParams:params task:task responseObject:nil error:error SuccessBlock:successBlock failureBlock:failureBlock];
            }];
             [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        }
            break;
            
        case YHHttpRequestPost: {
            self.task = [manager POST:self.requestUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                 [self requestFinishedWithParams:params task:task responseObject:responseObject error:nil SuccessBlock:successBlock failureBlock:failureBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self requestFinishedWithParams:params task:task responseObject:nil error:error SuccessBlock:successBlock failureBlock:failureBlock];
            }];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        }
            break;
            
        case YHHttpRequestPostUpload: {
            self.requestUrl = @"http://foreman.91thd.com/GcManage/uploadSinglePic";
            UIImage *headImage = [[UIImage alloc] init];;
            NSData *imageData = UIImageJPEGRepresentation(headImage, 1);
            [manager POST:self.requestUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                //根据实际情况，自行添加
                 [formData appendPartWithFileData:imageData name:@"headFile" fileName:@"logo.jpg" mimeType:@"image/jpeg"];
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                //根据实际情况，自行添加
             NSString *progress = [NSString stringWithFormat:@"当前下载进度:%.2f%%",100.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount];
                NSLog(@"progress -  %@",progress);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self requestFinishedWithParams:nil task:task responseObject:responseObject error:nil SuccessBlock:successBlock failureBlock:failureBlock];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                 [self requestFinishedWithParams:nil task:task responseObject:nil error:error SuccessBlock:successBlock failureBlock:failureBlock];
            }];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = false;
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Private MeZYods
#pragma mark 网络请求结束后请求结果的分析
- (void)requestFinishedWithParams:(NSDictionary *)params task:(NSURLSessionDataTask *)task responseObject:(id)responseObject error:(NSError *)error SuccessBlock:(YHRequestFinishedBlock)successBlock failureBlock:(YHRequestFinishedBlock)failureBlock {
    
    NSLog(@"====================== AFTER_ENCODE_REQUEST_PARAMS ======================\n\n%@\n\n%@\n\n", self.requestUrl, params);
    
    NSURLRequest *request = task.currentRequest;
    NSLog(@"====================== REQUEST_HEADER  ======================\n\n%@\n\n", request.allHTTPHeaderFields);
    
    NSInteger responseErrorCode  = error.code;
    
    NSHTTPURLResponse * response = (NSHTTPURLResponse*)task.response;
    NSInteger statusCode = response.statusCode;
    YHLog(@"statusCode -    %ld",statusCode);
    
    NSLog(@"====================== RESPONSE_HEADER ======================\n\n%@\n\n", response);
    
    NSLog(@"====================== RESPONSE_CONTENT ======================\n\n%@\n\n", responseObject);
    
    if (statusCode == YHStatusCodeTypeRequsetSuccess) {//请求成功
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *resultDict = dict.mutableCopy;
        
        YHResponseResult * result = [YHResponseResult resultFromResponseObject:resultDict];
        result.responseHeaderFields = response.allHeaderFields;
        NSLog(@"====================== AFTER_DECODE_RESPONSE_CONTENT ======================\n\n%@\n\n", resultDict);
        if ([result success]) {
            successBlock(result);
            
        } else if (result.errorCode == YHStatusCodeTypeTokenError){//token错误
            //TOKEN错误，发送通知，重新登录
//            [NOTICATION_CENTER postNotificationName:ACCOUNT_ABNORMAL_NOTIFICATION object:nil];
//            failureBlock(result);
            
        } else {
            failureBlock(result);
        }
        
    } else if (statusCode == YHStatusCodeTypeSessionTimeOut) {//请求超时
        
        // 网络请求失败
        NSLog(@"====================== RESPONSE TOKEN TIMEOUT ======================\n\n");
        YHResponseResult *result = [[YHResponseResult alloc] init];
        result.failResponseDesc = @"您登录已超时，请重新登录";
        result.errorCode = statusCode;
        failureBlock(result);
        return;
        
    } else {
        
        // 网络请求失败
        NSLog(@"====================== RESPONSE FAILURE ======================\n\n%d\n\n", (int)error.code);
        
        if (error) {
            
            switch (responseErrorCode) {
                    
                case kCFURLErrorTimedOut:
                case kCFURLErrorBadServerResponse: {
                    //登录超时
                    YHResponseResult *result = [[YHResponseResult alloc]init];
                    result.errorCode = responseErrorCode;
                    result.failResponseDesc = @"服务端异常，请稍后重试！";
                    failureBlock(result);
                    break;
                }
                    
                case kCFURLErrorCannotConnectToHost:
                case kCFURLErrorNotConnectedToInternet: {
                    //网络无法连接
                    YHResponseResult *result = [[YHResponseResult alloc] init];
                    result.errorCode = responseErrorCode;
                    result.failResponseDesc = @"网络异常，请稍后再试";
                    failureBlock(result);
                    
                    break;
                }
                    
                default: {
                    
                    // 未知错误不进行判断
                    YHResponseResult *result = [[YHResponseResult alloc] init];
                    result.failResponseDesc = @"未知错误";
                    failureBlock(result);
                    return;
                    
                }
            }
        } else {//error = nil
            
            YHResponseResult *result = [[YHResponseResult alloc] init];
            result.responseHeaderFields = response.allHeaderFields;
            result.failResponseDesc = @"服务端发生异常，请稍后再试";
            failureBlock(result);
        }
    }
    
}

#pragma mark - 设置请求头
- (void)configRequestSerializer:(AFHTTPRequestSerializer <AFURLRequestSerialization> *)serializer {
    
    [serializer setValue:[YHSystempParameterConfi sharedInstance].deviceID forHTTPHeaderField:@"deveiceID"];
    [serializer setValue:[YHSystempParameterConfi sharedInstance].bundleVersion forHTTPHeaderField:@"bundleVersion"];
    YHLog(@"HTTPRequestHeaders -   %@",serializer.HTTPRequestHeaders);
    //这里通常情况下会把token作为请求头，登录成功后拿到token，在这里配置。
}

- (void)cancel {
    if (self.task) {
        [self.task cancel];
    }
    self.task = nil;
}

- (void)dealloc {
    
    NSLog(@"THRequest Dealloc");
}

@end
