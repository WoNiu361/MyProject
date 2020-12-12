//
//  UIViewController+DZNEmpty.m
//  taotaotuan-agent-ios
//
//  Created by 吕颜辉 on 2018/6/18.
//  Copyright © 2018 吕颜辉. All rights reserved.
//

#import "UIViewController+DZNEmpty.h"
#import <objc/runtime.h>

@implementation UIViewController (DZNEmpty)

- (void)setupDZNEmptyWithNoDataWithScrollView:(UIScrollView *)scrollView {
    [self setupDZNEmptyWithNoDataWithScrollView:scrollView EmptyImageName:@"emptyData"];
}

- (void)setupDZNEmptyWithNoDataWithScrollView:(UIScrollView *)scrollView EmptyImageName:(NSString *)imageName {
    [self setupDZNEmptyWithNoDataWithScrollView:scrollView EmptyImageName:imageName EmptyTitle:@"暂无数据"];
}

-(void)setupDZNEmptyWithNoDataWithScrollView:(UIScrollView *)scrollView EmptyImageName:(NSString *)imageName EmptyTitle:(NSString *)title {
    if (!imageName) {
        imageName = @"emptyData";
    }
    if (!title) {
        title = @"暂无数据";
    }
    [self setupDZNEmptyWithScrollView:scrollView EmptyImageName:imageName EmptyTitle:title EmptyDescription:@"点击屏幕重新加载" EmptyBgColor:kGlobalBgColor];
}

- (void)setupDZNEmptyWithNoNetWithScrollView:(UIScrollView *)scrollView {
    [self setupDZNEmptyWithNoNetWithScrollView:scrollView EmptyImageName:@"netError"];
}

- (void)setupDZNEmptyWithNoNetWithScrollView:(UIScrollView *)scrollView EmptyImageName:(NSString *)imageName {
    [self setupDZNEmptyWithScrollView:scrollView EmptyImageName:imageName EmptyTitle:@"网络错误" EmptyDescription:@"点击屏幕重新加载" EmptyBgColor:kGlobalBgColor];
}

- (void)setupDZNEmptyWithScrollView:(UIScrollView *)scrollView EmptyImageName:(NSString *)imageName EmptyTitle:(NSString *)title EmptyDescription:(NSString *)description EmptyBgColor:(UIColor *)bgColor{
    scrollView.emptyDataSetDelegate = self;
    scrollView.emptyDataSetSource = self;
    self.scrollView = scrollView;
    self.empty_imageName = imageName;
    self.empty_title = title;
    if (!self.empty_description) {
        self.empty_description = description;
    }
    self.empty_bgColor = bgColor;
    [scrollView reloadEmptyDataSet];
}

#pragma mark - DZNEmptyDataSetDataSource

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:self.empty_imageName];
}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return self.empty_bgColor ?: kGlobalBgColor;
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.verticalOffset;
}

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSDictionary *attributes = @{
                                 NSFontAttributeName:self.titleFont?:[UIFont systemFontOfSize:17 weight:UIFontWeightRegular],NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                 };
    return [[NSAttributedString alloc] initWithString:self.empty_title?:@"" attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:13 weight:UIFontWeightRegular],
                                 NSForegroundColorAttributeName:[UIColor lightGrayColor]
                                 };
    return [[NSAttributedString alloc] initWithString:self.empty_description?:@"" attributes:attributes];
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.emptyTapCallBack) {
        self.emptyTapCallBack();
    } else {
        [self.scrollView.mj_header beginRefreshing];
    }
}

- (CGFloat)verticalOffset {
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}

- (void)setVerticalOffset:(CGFloat)verticalOffset {
    objc_setAssociatedObject(self, @selector(verticalOffset), @(verticalOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (UIScrollView *)scrollView {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setScrollView:(UIScrollView *)scrollView {
    objc_setAssociatedObject(self, @selector(scrollView), scrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)empty_imageName {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setEmpty_imageName:(NSString *)empty_imageName {
    objc_setAssociatedObject(self, @selector(empty_imageName), empty_imageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)empty_title {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setEmpty_title:(NSString *)empty_title {
    objc_setAssociatedObject(self, @selector(empty_title), empty_title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)empty_description {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setEmpty_description:(NSString *)empty_description {
    objc_setAssociatedObject(self, @selector(empty_description), empty_description, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)empty_bgColor {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmpty_bgColor:(UIColor *)empty_bgColor {
    objc_setAssociatedObject(self, @selector(empty_bgColor), empty_bgColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)titleFont {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setTitleFont:(UIFont *)titleFont {
    objc_setAssociatedObject(self, @selector(titleFont), titleFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(void))emptyTapCallBack {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setEmptyTapCallBack:(void (^)(void))emptyTapCallBack {
    objc_setAssociatedObject(self, @selector(emptyTapCallBack), emptyTapCallBack, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
