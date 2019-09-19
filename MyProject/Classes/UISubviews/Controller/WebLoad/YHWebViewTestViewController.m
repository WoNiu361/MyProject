//
//  YHWebViewTestViewController.m
//  MyProject
//
//  Created by LYH on 2019/9/7.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHWebViewTestViewController.h"

@interface YHWebViewTestViewController ()

@end

@implementation YHWebViewTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WEB测试";
    
    [self loadWebViewWithUrl:@"https://www.baidu.com/"];
}



@end
