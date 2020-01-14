//
//  YHDispatch_groupViewController.m
//  MyProject
//
//  Created by 吕颜辉 on 2019/12/28.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHDispatch_groupViewController.h"

@interface YHDispatch_groupViewController ()

@end

@implementation YHDispatch_groupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"线程组";
   
   /**
    相关解释，请参照  YHDispatch_group  这个文件，里面的解释说明
    */
}

- (void)test3 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    NSLog(@"group start  ");
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"enter - 11");
        dispatch_group_enter(group);
        dispatch_async(queue, ^{
            NSLog(@"enter -  22");
            dispatch_group_leave(group);
        });
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"group task finish");
    });
#warning 切记 dispatch_group_enter 和 dispatch_group_leave 必须成对出现，并且 dispatch_group_enter 必须在 dispatch_group_leave 之前出现
    
#warning 如果dispatch_group_enter和dispatch_group_leave不成对出现会出现什么结果？
    /**
  通过dispatch_group_enter告知group，一个任务开始，未执行完毕任务数加1，在异步线程任务执行完毕时，通过dispatch_group_leave告知group，一个任务结束，未执行完毕任务数减1，当未执行完毕任务数为0的时候，这时group才认为组内任务都执行完毕了（这个和GCD的信号量的机制有些相似），这时候才会回调dispatch_group_notify中的block。

     */
}

- (void)test2 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    NSLog(@"group start  ");
    dispatch_group_async(group, queue, ^{
        NSLog(@"enter - 11");
        dispatch_async(queue, ^{
            sleep(1);//这里线程睡眠1秒钟，模拟异步请求
            NSLog(@"group task fiish");
        });
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"group resuset finsh");
    });
    
    /**
     打印如下所示：
     2019-12-28 11:09:00.434724+0800 MyProject[3344:1224826] group start
     2019-12-28 11:09:00.434973+0800 MyProject[3344:1224855] enter - 11
     2019-12-28 11:09:00.435215+0800 MyProject[3344:1224852] group resuset finsh
     2019-12-28 11:09:01.440220+0800 MyProject[3344:1224855] group task fiish
     
     从打印结果可以看出，在group中嵌套了一个异步任务时，group并没有等待group内的异步任务执行完毕才进入dispatch_group_notify中，
     这是因为，在dispatch_group_async中又启了一个异步线程，而异步线程是直接返回的，所以group就认为是执行完毕了。
     要解决该问题，方案是使用dispatch_group_enter和dispatch_group_leave方法来告知group组内任务何时才是真正的结束。
     参照 [self test3];
     */
}

- (void)test1 {
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"task fisrst finish ");
        NSLog(@"thread - 1 -   %@",[NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"task second finish ");
        sleep(8);
        NSLog(@"thread - - 2  %@",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"notify - action ");
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"before -   ");
        dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
        NSLog(@"task finish ");
    });
}

- (void)groupFunction {

       dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
       dispatch_group_t group = dispatch_group_create();
       dispatch_group_async(group, queue, ^{
           dispatch_group_enter(group);
           // dispatch_group_wait会阻塞当前线程(所以不能放在主线程调用)一直等待
           dispatch_group_wait(group, dispatch_time(DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC));
           dispatch_group_leave(group);
       });
       
    //上面的一系列操作完后，会触发dispatch_group_notify
       dispatch_group_notify(group, dispatch_get_main_queue(), ^{
           
       });
}

#pragma mark - 参照的网站
- (void)refrerWebsite {
    /**
     https://www.jianshu.com/p/228403206664
     https://juejin.im/post/5c761be8f265da2d993d9578
     https://www.cnblogs.com/ziyi--caolu/p/4900650.html
     https://www.jianshu.com/p/6faea7ef35bc
     
     */
    
    
}
@end
