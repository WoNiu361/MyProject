//
//  YHBaseWebLoadViewController.m
//  MyProject
//
//  Created by LYH on 2019/9/7.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHBaseWebLoadViewController.h"
#import <WebKit/WebKit.h>

@interface YHBaseWebLoadViewController ()<WKNavigationDelegate,WKUIDelegate>
@property (nonatomic, strong) WKWebView       *webView;
@property (nonatomic, strong) UIBarButtonItem *customBackBarItem;
/**  关闭按钮   */
@property (nonatomic, strong) UIBarButtonItem *closeButtonItem;
/**  刷新按钮   */
@property (nonatomic, strong) UIBarButtonItem *refreshButtonItem;
/**    导航下的进度条，显示网页的加载进度   */
@property (nonatomic, strong) UIView          *progressView;
/**    <#*#>   */
@property (nonatomic, assign) NSInteger       page;
@end

@implementation YHBaseWebLoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"加载网页";
    self.navigationItem.rightBarButtonItem = self.refreshButtonItem;
    
    [self.view addSubview:self.webView];
    [self.view addSubview:self.progressView];
    
    [self updateNavigationItems];
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
//    [self updateNavigationItems];
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
    self.title = @"加载失败";
    //可以展示几个空的占位，表明加载失败
}
#pragma mark - 这个方法，当你点击H5页面中的n内容时，会调用多次。调用 [self.webView reload];方法，也会调用多次
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationAction");
    decisionHandler(WKNavigationActionPolicyAllow);
}
#pragma mark - 这个方法，当你点击H5页面中的n内容时，会调用一次。调用 [self.webView reload];方法，也会调一次
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSLog(@"decidePolicyForNavigationResponse");
    self.page ++;
    [self updateNavigationItems];
    decisionHandler(WKNavigationResponsePolicyAllow);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.hidden = false;
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.progressView.frame = CGRectMake(0, 0, MainScreenWidth * self.webView.estimatedProgress, 2);
        } completion:nil];
        //下面动画是为了防止加载进度在快速请求另外的网页的时候
        //出现进度条回缩的问题
        if (self.webView.estimatedProgress >= 1.0) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                
            } completion:^(BOOL finished) {
                self.progressView.frame = CGRectMake(0, 0, 0, 2);
                self.progressView.hidden = true;
            }];
        }
    } else if ([keyPath isEqualToString:@"title"]) {
        if (object == self.webView) {
            self.title = self.webView.title;
        }
    }
}

#pragma mark - 更新左侧按钮
-(void)updateNavigationItems{
    if (self.page > 1) {
          [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem,self.closeButtonItem] animated:NO];
    } else {
         [self.navigationItem setLeftBarButtonItems:@[self.customBackBarItem]];
    }
}

- (void)loadWebViewWithUrl:(NSString *)urlString {
    NSLog(@"urlString -     %@",urlString);
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [self.webView loadRequest:request];
}

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        //允许侧滑返回上层
        _webView.allowsBackForwardNavigationGestures = true;
        NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        [_webView loadRequest:request];
        
        //监听进度条变化
        [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionOld context:nil];
        
        //监听网页的标题
        [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
        [_webView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"obj - obj -    %@",obj);
            if ([obj isKindOfClass:[UIScrollView class]]) {
                [(UIScrollView *)obj setShowsHorizontalScrollIndicator:false];
                [(UIScrollView *)obj setShowsVerticalScrollIndicator:false];
            }
        }];
    }
    return _webView;
}

- (UIView *)progressView {
    if (_progressView == nil) {
        _progressView = [UIView viewWithBackgroundColor:[UIColor greenColor] frame:CGRectMake(0, 0,0, 2)];
    }
    return _progressView;
}

- (UIBarButtonItem *)customBackBarItem {
    if (_customBackBarItem == nil) {
        _customBackBarItem = [UIBarButtonItem itemWithImage:@"navigation_back" target:self action:@selector(customBackBarClick:)];
    }
    return _customBackBarItem;
}

-(UIBarButtonItem *)closeButtonItem {
    if (_closeButtonItem == nil) {
        _closeButtonItem = [UIBarButtonItem itemWithImage:@"closeItem" target:self action:@selector(closeButtonItemClick:)];
    }
    return _closeButtonItem;
}

#pragma mark - 刷新页面
-(UIBarButtonItem *)refreshButtonItem {
    if (_refreshButtonItem == nil) {
        _refreshButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"刷新" style:UIBarButtonItemStylePlain target:self action:@selector(refreshButtonItemClick:)];
    }
    return _refreshButtonItem;
}
#pragma mark - 返回
- (void)customBackBarClick:(UIBarButtonItem *)item {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        self.page --;
        [self updateNavigationItems];
    } else {
        [self closeButtonItemClick:item];
    }
}
#pragma mark - 关闭
- (void)closeButtonItemClick:(UIBarButtonItem *)item {
     [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 刷新页面数据
- (void)refreshButtonItemClick:(UIBarButtonItem *)item {
    
    self.page --;
    //调用这个方法，代理的方法都会被调用，就会地址page加 1 ，所以上面要先减去 1，
    [self.webView reload];
}

- (void)dealloc {
    
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
}

@end
