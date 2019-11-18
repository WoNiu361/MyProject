//
//  YHHttpRequestTool.m
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/11.
//  Copyright © 2019 LYH. All rights reserved.
//

#import "YHHttpRequestTool.h"
#import "YHResponseResult.h"
#import "ServiceConfigure.h"

@interface YHHttpRequestTool ()
/**   当前网络任务集合   */
@property (nonatomic, strong) NSMutableArray<YHHttpRequest *> *taskArray;
@end

@implementation YHHttpRequestTool

-(NSMutableArray<YHHttpRequest *> *)taskArray {
    if (_taskArray == nil) {
        _taskArray = [NSMutableArray array];
    }
    return _taskArray;
}

- (void)startTaskWithParams:(NSDictionary *)params
                       path:(NSString *)path
                     method:(YHHttpRequestType)type
                  coverType:(CoverAlertType)coverType
               successBlock:(YHRequestFinishedBlock)successBlock
               failureBlock:(YHRequestFinishedBlock)failureBlock {
    
    switch (coverType) {
        case CoverAlertType_None: {
            
        }
            break;
            
        case CoverAlertType_Toast: {
            YHLog(@"加载中...");
        }
            break;
            
        default:
            break;
    }
    
    YHHttpRequest *request = [[YHHttpRequest alloc] init];
    request.requestType = type;
    request.requestPath = path;
    [request startWithParams:params successBlock:^(YHResponseResult *result) {
        if (successBlock) {
            successBlock(result);
        }
    } failureBlock:^(YHResponseResult *result) {
        if (failureBlock) {
            failureBlock(result);
        }
    }];
    [self.taskArray addObject:request];
};

- (void)cancelTask {
    [self.taskArray enumerateObjectsUsingBlock:^(YHHttpRequest * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj cancel];
    }];
    [self.taskArray removeAllObjects];
}
#warning 注意，这个类，一定要用懒加载处理，否则会请求不到数据，报错
- (void)dealloc {
    NSLog(@"task-dealloc");
    [self cancelTask];
}


@end
