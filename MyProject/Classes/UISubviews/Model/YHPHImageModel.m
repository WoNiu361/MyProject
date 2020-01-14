//
//  YHPHImageModel.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "YHPHImageModel.h"

@implementation YHPHImageModel

-(NSMutableArray<YHSelectImageModel *> *)phoneArray {
    if (_phoneArray == nil) {
        _phoneArray = [NSMutableArray array];
    }
    return _phoneArray;
}

-(NSMutableArray<UIImage *> *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

@end



@implementation YHSelectImageModel


@end
