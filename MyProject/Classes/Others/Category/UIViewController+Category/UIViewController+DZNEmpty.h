//
//  UIViewController+DZNEmpty.h
//  taotaotuan-agent-ios
//
//  Created by 吕颜辉 on 2018/6/18.
//  Copyright © 2018 吕颜辉. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (DZNEmpty)<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, copy) NSString *empty_imageName;
@property (nonatomic, copy) NSString *empty_title;
@property (nonatomic, copy) NSString *empty_description;
@property (nonatomic, strong) UIColor *empty_bgColor;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, assign) CGFloat verticalOffset;

// 默认图片：empty  标题：暂无数据  背景颜色：GHYBackGroundColor
- (void)setupDZNEmptyWithNoDataWithScrollView:(UIScrollView *)scrollView;
// 自定义图片    默认标题：暂无数据  背景颜色：GHYBackGroundColor
- (void)setupDZNEmptyWithNoDataWithScrollView:(UIScrollView *)scrollView EmptyImageName:(NSString *)imageName;
// 自定义图片   自定义标题          背景颜色：GHYBackGroundColor
- (void)setupDZNEmptyWithNoDataWithScrollView:(UIScrollView *)scrollView EmptyImageName:(NSString *)imageName EmptyTitle:(NSString *)title;

// 默认图片：netError   标题：网络错误  背景颜色：GHYBackGroundColor
- (void)setupDZNEmptyWithNoNetWithScrollView:(UIScrollView *)scrollView;
// 自定义图片        默认标题：网络错误  背景颜色：GHYBackGroundColor
- (void)setupDZNEmptyWithNoNetWithScrollView:(UIScrollView *)scrollView EmptyImageName:(NSString *)imageName;

// 公用方法，可以自定义图片，标题，刷新文字，背景颜色
- (void)setupDZNEmptyWithScrollView:(UIScrollView *)scrollView EmptyImageName:(NSString *)imageName EmptyTitle:(NSString *)title EmptyDescription:(NSString *)description EmptyBgColor:(UIColor *)bgColor;

// 自定义刷新回调
@property (nonatomic, copy) void(^emptyTapCallBack)(void);

@end

/*
 用法:
 // self => ViewController
 // 无数据页面
 [self setupDZNEmptyWithNoDataWithScrollView:self.tableView];
 // 无网络页面
 [self setupDZNEmptyWithNoNetWithScrollView:self.tableView];
 
 // 刷新回调
 self.emptyTapCallBack = ^(){
 [self.scrollView.mj_header beginRefreshing];
 }
 */

NS_ASSUME_NONNULL_END
