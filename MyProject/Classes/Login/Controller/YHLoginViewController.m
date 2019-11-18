//
//  YHLoginViewController.m
//  MyProject
//
//  Created by LYH on 2019/10/21.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHLoginViewController.h"
#import "YHAccountTool.h"

@interface YHLoginViewController ()
/**   <#注释#>    */
@property (nonatomic, assign) NSInteger toucAccount;
@end

@implementation YHLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    NSDictionary *dic = @{
                          @"sex" :@"1",
                          @"avatarUrl":@"https://www.baidu.com",
                          @"nickName":@"狂奔的蜗牛",
                          @"bindState":@1
                          };
    YHAccount *account = [YHAccount mj_objectWithKeyValues:dic];
    [[YHAccountTool sharedYHAccountTool] saveAccountInfo:account];
    
    self.toucAccount = 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSString *nickName = [YHAccountTool sharedYHAccountTool].account.nickName;
    NSInteger bindState = [YHAccountTool sharedYHAccountTool].account.bindState;
    NSLog(@"naickName -  %@  \n  -  %ld",nickName,bindState);
    
    self.toucAccount ++;
    if (self.toucAccount == 3) {
        [[YHAccountTool sharedYHAccountTool] removeAccount];
         NSString *shift = [YHAccountTool sharedYHAccountTool].account.nickName;
        NSLog(@"lala-  %@",shift);
    } else {
        
    }
    
    

}




@end
