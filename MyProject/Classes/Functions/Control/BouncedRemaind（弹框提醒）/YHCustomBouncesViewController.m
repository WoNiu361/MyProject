//
//  YHCustomBouncesViewController.m
//  MyProject
//
//  Created by LYH on 2019/8/1.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHCustomBouncesViewController.h"
#import "HRShowSelectAlertView.h"
#import "MBProgressHUD+YHProgressHUD.h"

@interface YHCustomBouncesViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,HRShowSelectAlertViewDelegate>
/**    数据   */
@property (nonatomic, strong) NSMutableArray<NSString *> *dataArray;
@end
static NSString * const reuseIdentifier = @"YHCustomBouncesViewController";
@implementation YHCustomBouncesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"自定义弹框";
    
    self.dataArray = [NSMutableArray arrayWithObjects:@"底部弹框",@"成功提示",@"错误提示",@"文本提示",@"文本提示带标题",@"底部弹框",@"底部弹框", nil];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MainScreenWidth/4.0, 60);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    UICollectionView *bouncesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - kNavgationBarAndStatusBarHeight) collectionViewLayout:layout];
    bouncesCollectionView.delegate = self;
    bouncesCollectionView.dataSource = self;
    bouncesCollectionView.backgroundColor = kGlobalBgColor;
    [bouncesCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:bouncesCollectionView];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    //防止复用
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    UILabel *lab = [UILabel labelWithTitle:self.dataArray[indexPath.item] withTitleColor:[UIColor whiteColor] withTitleFont:15 withFrame:cell.bounds withTextAligement:NSTextAlignmentCenter textWeigt:UIFontWeightBold];
    lab.numberOfLines = 2;
    [cell.contentView addSubview:lab];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        HRShowSelectAlertView *alertView = [[HRShowSelectAlertView alloc] initWithFrame:CGRectZero title:@"取消" titleArray:@[@"拍照",@"从相册选择"]];
        alertView.delegate = self;
        [kWindow addSubview:alertView];
    } else if (indexPath.item == 1) {
        [MBProgressHUD showSuccess:@"加载成功..." showView:self.view];
    } else if (indexPath.item == 2) {
        [MBProgressHUD showError:@"保存失败..." showView:self.view];
    } else if (indexPath.item == 3) {
        [MBProgressHUD showMessage:@"审核成功，请注意保存你的账号" showView:self.view];
    } else if (indexPath.item == 4) {
        [MBProgressHUD showMessage:@"爱你一万年，摸摸哒" title:@"温馨提醒" showView:self.view];
    }
}

- (void)view:(HRShowSelectAlertView *)alertView selectPhotoWithTag:(NSInteger)tag {
    switch (tag) {
        case HeadImageTakePhoto: {
            kFunctionLogo;
        }
            break;
            
        case HeadImageSelectPhotoLibrary: {
             kFunctionLogo;
        }
            break;
            
        default:
            break;
    }
}
@end
