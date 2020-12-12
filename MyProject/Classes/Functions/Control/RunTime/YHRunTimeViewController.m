//
//  YHRunTimeViewController.m
//  MyProject
//
//  Created by LYH on 2019/8/2.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHRunTimeViewController.h"
#import "YHRunTimeTestModel.h"

@interface YHRunTimeViewController ()

@end

@implementation YHRunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"runTime知识";
    
    //objc_property_t  表示类对象中的全局属性，即用@property定义的属性。
    //Ivar  表示类对象中的所有定义的全局变量,每一个继承NSObject的类会自动得到runtime的支持,使用@property 方式定义属性时，编译器会自动为我们添加setter，getter方法并定义一个私有变量，变量前自动加_。所以，Ivar会包含@property定义的全部属性。
    [self getProperties];
    
    [self getIvars];
}

- (void)getProperties {
    
    unsigned int count = 0;
    //获取属性
    objc_property_t *properties = class_copyPropertyList([UITextField class], &count);
    for (int i = 0; i < count; i ++) {
        //取出属性
        objc_property_t property = properties[i];
        
        MyLog(@"property -  %s  -  -    %s",property_getName(property),property_getAttributes(property));
    }
}


#pragma - 查看隐藏的成员变量
- (void)getIvars {
    unsigned int count = 0;
    
    // 拷贝出所有的成员变量列表
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i<count; i++) {
        // 取出成员变量
        //        Ivar ivar = *(ivars + i);
        //指针和数组有很多相似的地方
        //指针访问数组元素时，可以如下访问（指针指向数组的首元素时）
        Ivar ivar = ivars[i];
        // 打印成员变量名字
        MyLog(@"ivar -   %s     -    %s", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
      
        NSString *keyStr = [NSString stringWithUTF8String:ivar_getName(ivar)];
        MyLog(@"keyStr -   %@",keyStr);
        //每一个继承NSObject的类会自动得到runtime的支持,使用@property 方式定义属性时，编译器会自动为我们添加setter，getter方法并定义一个私有变量，变量前自动加_。所以，Ivar会包含@property定义的全部属性。
    }
    // 释放
    free(ivars);
}





/*
 下面对应的编码值可以在官方文档里面找到
 编码值   含意
 c     代表char类型
 i     代表int类型
 s     代表short类型
 l     代表long类型，在64位处理器上也是按照32位处理
 q     代表long long类型
 C     代表unsigned char类型
 I     代表unsigned int类型
 S     代表unsigned short类型
 L     代表unsigned long类型
 Q     代表unsigned long long类型
 f     代表float类型
 d     代表double类型
 B     代表C++中的bool或者C99中的_Bool
 v     代表void类型
 *     代表char *类型
 @     代表对象类型
 #     代表类对象 (Class)
 :     代表方法selector (SEL)
 [array type]  代表array
 {name=type…}  代表结构体
 (name=type…)  代表union
 bnum  A bit field of num bits
 ^type     A pointer to type
 ?     An unknown type (among other things, this code is used for function pointers)
 */
@end
