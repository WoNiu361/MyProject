//
//  YHGetPhotoAlbumImageViewController.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "YHGetPhotoAlbumImageViewController.h"
#import "YHPHImageModel.h"
#import "YHSelectImageCollectionViewCell.h"
#import "YHPreviewImageViewController.h"

#import <Photos/Photos.h>

/**

PHAsset : 一个资源, 比如一张图片\一段视频
PHAssetCollection : 一个相簿
PHImageManager 图片管理者,是单例,发送请求才能从asset获取图片
PHImageRequestOptions图片请求选项

*/

@interface YHGetPhotoAlbumImageViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YHSelectImageCollectionViewCellDelegate>
/**  全部图片  */
@property (nonatomic, strong) NSMutableArray<YHPHImageModel *> *photoArray;
/**   所有的文件夹数量    */
@property (nonatomic, assign) NSInteger                         allPhotoAlbumInt;
/**   选中的文件夹,默认是0，全部文件夹    */
@property (nonatomic, assign) NSInteger                         selectFolderInteger;
/**   选择图片的数量    */
@property (nonatomic, assign) NSInteger                         selectImageAmountInteger;

@property (nonatomic, strong) UICollectionView                  *imageCollectionView;

@property (nonatomic, weak) HRPriviewImageBottomView            *bottomView;
@end
static NSString *const imageID = @"YHSelectImageCollectionViewCell";
@implementation YHGetPhotoAlbumImageViewController

- (instancetype)init {
    if (self = [super init]) {
        self.selectFolderInteger      = 1;
        self.selectImageAmountInteger = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"获取相册图片";
    
    [self setupSubviews];
}

- (void)setupSubviews {
    
    self.photoArray = [NSMutableArray array];
    [YHSVProgressHUD showLoadingWithStatus:@"加载中..."];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getOriginalImages];
    });
    
    HRPriviewImageBottomView *bottomView = [[HRPriviewImageBottomView alloc] initWithFrame:CGRectMake(0, MainScreenHeight - kSafeAreaHeight - 60 - kNavgationBarAndStatusBarHeight, MainScreenWidth, 60 + kSafeAreaHeight)];
    [bottomView showDataWithTitle:@"打开相册" hide:false];
    @weakify(self);
    bottomView.openAlbumBlock = ^{
        @strongify(self);
        YHPhotoFolderView *folderView = [[YHPhotoFolderView alloc] initWithFrame:CGRectZero folderArray:self.photoArray];
        folderView.selectImageFolderBlock = ^(NSInteger idx) {
            self.selectFolderInteger = idx;
            [self.imageCollectionView reloadData];
        };
        [folderView showSubviews];
    };
    [self.view addSubview:bottomView];
    self.bottomView = bottomView;
    
    CGFloat itemWidth = (MainScreenWidth - 2 * 3)/3.0;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumLineSpacing = 3;
    layout.minimumInteritemSpacing = 3;
    
    self.imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.imageCollectionView.backgroundColor = kRGBColor(85, 85, 85);
    self.imageCollectionView.delegate = self;
    self.imageCollectionView.dataSource = self;
    [ self.imageCollectionView registerClass:[YHSelectImageCollectionViewCell class] forCellWithReuseIdentifier:imageID];
    [self.view addSubview: self.imageCollectionView];
    [ self.imageCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, bottomView.height, 0));
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.photoArray.count > 0) {
        YHPHImageModel *model = [self.photoArray objectAtIndex:self.selectFolderInteger];
        return model.phoneArray.count;
    } else {
        return 1;
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YHSelectImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageID forIndexPath:indexPath];
    if (self.photoArray.count > 0) {
        YHPHImageModel *model = [self.photoArray objectAtIndex:self.selectFolderInteger];
        cell.imageModel = model.phoneArray[indexPath.item];
        cell.delegate = self;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YHPreviewImageViewController *previewVC = [[YHPreviewImageViewController alloc] init];
    YHPHImageModel *model = [self.photoArray objectAtIndex:self.selectFolderInteger];
    previewVC.imageIndex = indexPath.item;
    previewVC.previewImageArray = model.imageArray;
    [self.navigationController pushViewController:previewVC animated:YES];
}

#pragma mark - cell 上按钮点击选中图片
- (void)selectImageWithCell:(YHSelectImageCollectionViewCell *)cell {
    
    NSIndexPath *indexPath = [self.imageCollectionView indexPathForCell:cell];
    YHPHImageModel *phModel = [self.photoArray objectAtIndex:self.selectFolderInteger];
    YHSelectImageModel *selectModel = [phModel.phoneArray objectAtIndex:indexPath.item];
    
    if (selectModel.selectAmount == 0) {
        self.selectImageAmountInteger ++;
        selectModel.selectAmount = self.selectImageAmountInteger;
        [self.imageCollectionView reloadData];
    } else {
        if (self.selectImageAmountInteger == 0) {
            self.selectImageAmountInteger = 0;
        } else {
            [phModel.phoneArray enumerateObjectsUsingBlock:^(YHSelectImageModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.selectAmount != 0 && obj.selectAmount > selectModel.selectAmount) {
                    NSInteger num = obj.selectAmount - 1;
                    obj.selectAmount = num;
                }
            }];
            selectModel.selectAmount = 0;
            self.selectImageAmountInteger --;
        }
        [self.imageCollectionView reloadData];
    }
    PPLog(@"selectImageAmountInteger -  %ld",self.selectImageAmountInteger);
    if (self.selectImageAmountInteger > 0) {
        [self.bottomView changeColor:true];
    } else {
        [self.bottomView changeColor:false];
    }
}

- (void)getOriginalImages {
    /**
     相册里的文件夹，每个文件夹里面对应很多图片，每一个图片又有很多信息，可以打印出来。
     思路：先获取文件夹，在获取文件夹里的图片，使用model在合适不过了。
     */
    
    // 获得相机胶卷,这个是系统里的 所有照片 分类
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
    
    //获得所有的自定义相册
    PHFetchResult<PHAssetCollection *> *assetColection = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSInteger count = assetColection.count;
    self.allPhotoAlbumInt = count + 1; //1是系统的 所有照片  文件夹
    
    PPLog(@"assetColection -  %@",assetColection);
    // 遍历所有的自定义相簿
    [assetColection enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self enumerateAssetsInAssetCollection:obj original:YES];
    }];
}

/**
 *  遍历相簿中的全部图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original {
    
    PPLog(@"相簿名:%@", assetCollection.localizedTitle);
    YHPHImageModel *model = [[YHPHImageModel alloc] init];
    model.photoAlbumName = assetCollection.localizedTitle;
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    options.resizeMode = PHImageRequestOptionsResizeModeFast;
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
     // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *result = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    [result enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 是否要原图
        CGSize imageSize = original ? CGSizeMake(obj.pixelWidth, obj.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:obj targetSize:imageSize contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            [model.imageArray addObject:result];
            PPLog(@"result -  %@\n  %@",result,info);
            YHSelectImageModel *imageModel = [[YHSelectImageModel alloc] init];
            imageModel.img = result;
            imageModel.selectAmount = 0;
            [model.phoneArray addObject:imageModel];
        }];
    }];
    [self.photoArray addObject:model];
    
    if (self.photoArray.count == self.allPhotoAlbumInt) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [YHSVProgressHUD dismiss];
            [self.imageCollectionView reloadData];
        });
    }
}


@end
