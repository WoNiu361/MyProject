//
//  YHMyUIViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/30.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHMyUIViewController.h"
#import "YHDrawLineView.h"

@interface YHMyUIViewController ()

@end

@implementation YHMyUIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"UIView知识";
    
    YHDrawLineView *lineView = [[YHDrawLineView alloc] initWithFrame:CGRectMake(0, 5, MainScreenWidth, 50)];
    [self.view addSubview:lineView];
    
   #pragma mark - 水平虚线
    YHDrawHorizontalImaginaryLineView *horizintalLineView = [[YHDrawHorizontalImaginaryLineView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(lineView.frame) + 5, MainScreenWidth, 2)];
    [self.view addSubview:horizintalLineView];
    
    #pragma mark - 竖直虚线
    YHDrawVerticalImaginaryLineView *verticalLineView = [[YHDrawVerticalImaginaryLineView alloc] initWithFrame:CGRectMake(10, 0, 2, MainScreenHeight)];
    verticalLineView.lineColor = [UIColor redColor];
    verticalLineView.lineLength = 6;
    verticalLineView.lineSpacing = 3;
    [self.view addSubview:verticalLineView];
    
    YHVerticalImaginaryLineView *verticalView = [[YHVerticalImaginaryLineView alloc] initWithFrame:CGRectMake(20, 0, 2, MainScreenHeight) lineLength:6 lineSpacing:3 lineColor:[UIColor orangeColor]];
    [self.view addSubview:verticalView];
}



@end
