//
//  YHAccountTool.m
//  MyProject
//
//  Created by LYH on 2019/10/21.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHAccountTool.h"

// 文件路径
#define kFile  [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]

@implementation YHAccountTool
single_implementation(YHAccountTool)

- (instancetype)init {
    if (self = [super init]) {
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:kFile];
    }
    return self;
}

- (void)saveAccountInfo:(YHAccount *)account {
    
    _account = account;
    [NSKeyedArchiver archiveRootObject:account toFile:kFile];
}

- (void)removeAccount {
    
    _account = nil;
    if ([[NSFileManager defaultManager] fileExistsAtPath:kFile]) {
        [[NSFileManager defaultManager] removeItemAtPath:kFile error:nil];
    } else {
        NSLog(@"file不存在");
    }  
}

@end
