//
//  YHAFNTableViewController.m
//  MyProject
//
//  Created by 吕颜辉 on 2019/11/18.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHAFNTableViewController.h"
#import "YHHttpRequestTool.h"
#import "ServiceConfigure.h"
#import "YHHTTPSessionManager.h"
#import "AFNetworking.h"
#import "UIKit+AFNetworking.h"

@interface YHAFNTableViewController ()<UITableViewDelegate,UITableViewDataSource>
/**  下载进度展示  */
@property (nonatomic, strong) UILabel           *progressLabel;
/**  图片展示   */
@property (nonatomic, weak)   UIImageView       *imageView;
@property (nonatomic, strong) YHHttpRequestTool *tools;
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@end

@implementation YHAFNTableViewController

-(YHHttpRequestTool *)tools {
    if (_tools == nil) {
        _tools = [[YHHttpRequestTool alloc] init];
    }
    return _tools;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"AFN网络封装";
    self.titleArray = @[@"测试自己封装的AFNetworking",@"AFNetworking加载展示图片",@"下载"];
    
    CGFloat yHeight =  [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height;
    self.progressLabel = [UILabel labelWithTitle:@"进度：0.00" withTitleColor:[UIColor blackColor] withTitleFont:15 withFrame:CGRectMake(20, 10 , self.view.frame.size.width, 20) textWeigt:UIFontWeightMedium];
    [self.view addSubview:self.progressLabel];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 0, 200, 200)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.progressLabel.frame) + 100 + yHeight, self.view.frame.size.width, self.view.frame.size.height - 100 - 20) style:UITableViewStylePlain];
    tableView.rowHeight = 45;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"AFNetworkingTest";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self testMyPackageAFNetworking];
    } else if (indexPath.row == 1) {
        [self userAFNLoadImage];
    } else {
        [self downLoadBigFiles];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:true];
}

#pragma mark - 测试我自己封装的AFNetworking
- (void)testMyPackageAFNetworking {

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@"6F580243" forKey:@"appKey"];
    [params setObject:@"D2ABA2CE6F58024321980B7D3261C895" forKey:@"appSecret"];
    [params setObject:@"1,2,3,4" forKey:@"supplierIds"];
    [params setObject:@"1" forKey:@"pageIndex"];
    [params setObject:@"10" forKey:@"pageSize"];


    [self.tools startTaskWithParams:params path:@"/cps/goods/search" method:YHHttpRequestPost coverType:CoverAlertType_None successBlock:^(YHResponseResult * _Nonnull result) {
        NSLog(@"checkCode -    %@",result.responseContent);
    } failureBlock:^(YHResponseResult * _Nonnull result) {
        NSLog(@"eror -   %@",result.failResponseDesc);

    }];
}

#pragma mark - 用AFNetworking展示并下请求图片下载
- (void)userAFNLoadImage {

   NSString *urlStr = @"https://photocdn.sohu.com/20120224/Img335762920.jpg";
//    NSString *document = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
//    NSLog(@"document -   %@",document);
//
//    NSString *homePath = NSHomeDirectory();
//    NSLog(@"home根目录:%@", homePath);

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:urlStr parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject -   %@   - %@",responseObject,[NSThread currentThread]);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = (UIImage *)responseObject;
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error -   %@",error);
    }];

    /*
     1016错误：Request failed:unacceptable content-type:image/jpeg.  不支持的响应类型，在Content-Type属性中添加相应的支持内容字段即可；
     3840错误：json text did not start with array or object and option to allow fragments not sets。设置  manager.responseSerializer = [AFHTTPResponseSerializer serializer];即可
     */
}

#pragma mark - 下载大的文件
- (void)downLoadBigFiles {
  //method-first 下载，只能用AFURLSessionManager类里面的方法，method-second也能，但是不太好，因为不走completionHandler这个block，只走进度block。
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.timeoutIntervalForRequest = 30;
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg"]];
    __weak __typeof(self)weakSelf = self;
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        NSLog(@"currentThread -  %@",[NSThread currentThread]);
        //AFNetworking是异步请求，是在子线程执行，如果在UI界面上显示下载进度，则需要放在主线程中执行
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat progress = 100 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
            strongSelf.progressLabel.text = [NSString stringWithFormat:@"当前下载进度为：%.2f%%",progress];
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *path = [[NSFileManager defaultManager] URLForDirectory:NSDocumentDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:false error:nil];
        return [path URLByAppendingPathComponent:response.suggestedFilename];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"download finish -  %@",filePath);
    }];
    [downloadTask resume];

    /*
     //method-second
    NSString *urlStr = @"https://dldir1.qq.com/qqfile/QQforMac/QQ_V5.4.0.dmg";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:urlStr parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        dispatch_async(dispatch_get_main_queue(), ^{
            CGFloat progress = 100 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
            self.progressLabel.text = [NSString stringWithFormat:@"当前下载进度为：%.2f%%",progress];
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"进度 -   %@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];  */
}

@end
