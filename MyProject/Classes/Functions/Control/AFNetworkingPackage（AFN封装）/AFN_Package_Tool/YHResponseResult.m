//
//  YHResponseResult.m
//  AFNetworkingPackage
//
//  Created by LYH on 2019/10/10.
//  Copyright © 2019 LYH. All rights reserved.
//

#import "YHResponseResult.h"

@implementation YHResponseResult

+ (instancetype)resultFromResponseObject:(NSDictionary *)responseObject {
    
    YHResponseResult *result = [[YHResponseResult alloc] init];
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        
        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
            result.responseContent = responseObject[@"data"];
        }
        result.resonse = responseObject[@"data"];
        result.failResponseDesc = responseObject[@"msg"];
        result.errorCode = [responseObject[@"code"] integerValue];
        
    } else {
        NSLog(@"数据格式错误");
    }
    
    return result;
}

- (BOOL)success {
    //200这个值是服务器方规定的
    return self.errorCode == 200;
}

@end






@implementation YHFormData



@end
