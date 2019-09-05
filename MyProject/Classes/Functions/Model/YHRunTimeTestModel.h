//
//  YHRunTimeTestModel.h
//  MyProject
//
//  Created by LYH on 2019/8/2.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHRunTimeTestModel : NSObject

@property(nonatomic, copy) NSString       *nameStr;
@property(nonatomic, copy) NSString       *ageStr;
@property(nonatomic, copy) NSString       *sexStr;
@property(nonatomic, strong) NSArray      *testArray;
@property(nonatomic, strong) NSDictionary *dic;
@property(nonatomic, strong) NSSet        *set1;


@end

NS_ASSUME_NONNULL_END
