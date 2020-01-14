//
//  YHPreviewImageViewController.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "YHPreviewImageViewController.h"
#import "YHSelectImageCollectionViewCell.h"

@interface YHPreviewImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    NSInteger _currentPage;
    NSIndexPath *_zoomingIndexPath;
    BOOL _isHideNavigationBar;
    BOOL _isFirstCome;
}
/**   <##>   */
@property (nonatomic, weak) HRPriviewImageBottomView *bottomView;
/**   <##>   */
@property (nonatomic, weak) UICollectionView *previewCollectionView;
@end
static NSString *const imageID = @"HRPhotoCollectionViewCell";
@implementation YHPreviewImageViewController

- (instancetype)init {
    if (self = [super init]) {
        _isFirstCome = true;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"预览图片";
    
    [self setupSubviews];

      
      [KNotificationCenter addObserver:self selector:@selector(photoCellDidZooming:) name:HRPhotoCellDidZomming_Notification object:nil];
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadForScreenRotate:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)setupSubviews {
    
    HRPriviewImageBottomView *bottomView = [[HRPriviewImageBottomView alloc] initWithFrame:CGRectMake(0, MainScreenHeight - 60 - kSafeAreaHeight - kNavgationBarAndStatusBarHeight, MainScreenWidth, 60 + kSafeAreaHeight)];
    NSString *str = [NSString stringWithFormat:@"%ld/9",self.imageIndex + 1];
    [bottomView showDataWithTitle:str hide:true];
    bottomView.numberLabel.text = str;
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MainScreenWidth, MainScreenHeight);
    layout.minimumInteritemSpacing = 0.001;
    layout.minimumLineSpacing = 0.001;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *previewCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    previewCollectionView.backgroundColor = [UIColor clearColor];
    previewCollectionView.delegate = self;
    previewCollectionView.dataSource = self;
    previewCollectionView.showsHorizontalScrollIndicator = false;
    previewCollectionView.pagingEnabled = true;
    [previewCollectionView registerClass:[HRPreviewImageCollectionViewCell class] forCellWithReuseIdentifier:imageID];
    [self.view addSubview:previewCollectionView];
    self.previewCollectionView = previewCollectionView;
    [previewCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsZero);
    }];
    
    [self.view insertSubview:bottomView aboveSubview:previewCollectionView];
    if (@available(iOS 11.0, *)) {
        previewCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.previewImageArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HRPreviewImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageID forIndexPath:indexPath];
    cell.indexPath = indexPath;
    [cell resetZoomingScale];
    cell.showImageView.image = [self.previewImageArray objectAtIndex:indexPath.item];
    [cell resizeImageView];
//    @weakify(self);
//    cell.singleTapActionBlcok = ^(UITapGestureRecognizer * _Nonnull singleTapGesture) {
//        @strongify(self);
//        _isHideNavigationBar = !_isHideNavigationBar;
//        [self dismissNavigationBarAndBottomView:_isHideNavigationBar];
//    };
//    cell.doubleTapActionBlcok = ^(UITapGestureRecognizer * _Nonnull singleTapGesture) {
//        @strongify(self);
//        [self dismissNavigationBarAndBottomView:false];
//    };
    return cell;
}

- (void)viewDidLayoutSubviews {
    if (_isFirstCome) {
        _previewCollectionView.contentOffset = CGPointMake(MainScreenWidth * self.imageIndex, 0);
    }
    _isFirstCome = false;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
     
    _currentPage = scrollView.contentOffset.x / MainScreenWidth + 0.5;
    PPLog(@"_currentPage -   %ld",_currentPage);
    self.bottomView.numberLabel.text = [NSString stringWithFormat:@"%ld/9",_currentPage + 1];
    if (_zoomingIndexPath) {
        [self.previewCollectionView reloadItemsAtIndexPaths:@[_zoomingIndexPath]];
        _zoomingIndexPath = nil;
    }
}

- (void)photoCellDidZooming:(NSNotification *)notification {
    PPLog(@"notification - -- %@",notification.name);
    NSIndexPath *indexPath = notification.object;
    _zoomingIndexPath = indexPath;
}

- (void)reloadForScreenRotate:(NSNotification *)notification {
    
    self.previewCollectionView.frame = self.view.bounds;
    [self.previewCollectionView reloadData];
    self.previewCollectionView.contentOffset = CGPointMake(MainScreenWidth * _currentPage, 0);
}

- (void)dismissNavigationBarAndBottomView:(BOOL)isHide {
    
    self.bottomView.hidden = isHide;
    self.navigationController.navigationBar.hidden = isHide;
    [UIApplication sharedApplication].statusBarHidden = isHide;
}

@end
