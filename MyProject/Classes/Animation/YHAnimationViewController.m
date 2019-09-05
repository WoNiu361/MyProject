//
//  YHAnimationViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHAnimationViewController.h"

@interface YHAnimationViewController ()

@end

@implementation YHAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动画";
    self.view.backgroundColor = KRandomColor;
    self.navigationItem.leftBarButtonItem = nil;


}

////如果把该方法放在异步函数中执行，则方法不会被调用，因为touchesBegan方法只有在主线程中才会执行
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//
//    MyLog(@"currentThread -  %@",[NSThread currentThread]);
//    //在异步函数中执行
////    dispatch_queue_t queue = dispatch_queue_create("wedinging", 0);
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        NSLog(@"11111---%@",[NSThread currentThread]);
//        [self performSelector:@selector(test) withObject:nil afterDelay:2.0];
//         NSLog(@"22222---%@",[NSThread currentThread]);
//    });
//}
//
//- (void)test{
//    NSLog(@"异步函数中延迟执行----%@",[NSThread currentThread]);
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    MyLog(@"currentThread -  %@",[NSThread currentThread]);
        dispatch_queue_t queue = dispatch_queue_create("wedinging", NULL);
////    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        [self performSelector:@selector(test) withObject:nil afterDelay:2.0];
//
//    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), queue, ^{
        MyLog(@"909----  %@",[NSThread currentThread]);
    });
}

- (void)test{
    NSLog(@"异步函数中延迟执行----%@",[NSThread currentThread]);
}


@end
