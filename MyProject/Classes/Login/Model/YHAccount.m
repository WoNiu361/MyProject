//
//  YHAccount.m
//  MyProject
//
//  Created by LYH on 2019/10/21.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHAccount.h"

@implementation YHAccount

#pragma mark - 归档的时候调用

MJCodingImplementation

/*
 方法二：自己写下面的实现代码，得遵循  <NSCoding> 协议
 - (instancetype)initWithCoder:(NSCoder *)aDecoder {
 if (self = [super init]) {
 self.sex = [aDecoder decodeObjectForKey:@"sex"];
 self.avatarUrl = [aDecoder decodeObjectForKey:@"avatarUrl"];
 self.nickName = [aDecoder decodeObjectForKey:@"nickName"];
 self.bindState = [aDecoder decodeIntegerForKey:@"bindState"];
 }
 return self;
 }
 
 - (void)encodeWithCoder:(NSCoder *)aCoder {
 
 [aCoder encodeObject:self.sex forKey:@"sex"];
 [aCoder encodeObject:self.avatarUrl forKey:@"sex"];
 [aCoder encodeObject:self.nickName forKey:@"nickName"];
 [aCoder encodeInteger:self.bindState forKey:@"bindState"];
 }
 */

@end


