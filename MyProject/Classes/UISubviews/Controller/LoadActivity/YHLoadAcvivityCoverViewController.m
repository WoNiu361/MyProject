//
//  YHLoadAcvivityCoverViewController.m
//  MyProject
//
//  Created by LYH on 2019/10/28.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHLoadAcvivityCoverViewController.h"

@interface YHLoadAcvivityCoverViewController ()
/**   <##>   */
@property (nonatomic, weak) UIActivityIndicatorView *indicatorView;
@end

@implementation YHLoadAcvivityCoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
   
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.frame = CGRectMake(0, 0, 100, 100);
    indicatorView.center = self.view.center;
    [indicatorView startAnimating];
    [self.view addSubview:indicatorView];
    self.indicatorView = indicatorView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.indicatorView stopAnimating];
}


@end
