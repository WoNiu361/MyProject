//
//  YHMoveCollectionViewCellViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/29.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHMoveCollectionViewCellViewController.h"

@interface YHMoveCollectionViewCellViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *moveCollectionView;
/**    数据   */
@property (nonatomic, strong) NSMutableArray<NSString *> *dataArray;
@end
static NSString * const reuseIdentifier = @"collectionViewCell";
@implementation YHMoveCollectionViewCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"移动collectionViewCell";
    
    self.dataArray = [NSMutableArray array];
    for (int i = 1; i < 56; i ++) {
        NSString *str = [NSString stringWithFormat:@"%d",i];
        [self.dataArray addObject:str];
    }
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(MainScreenWidth/6.0, 60);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    _moveCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, MainScreenWidth, MainScreenHeight - kNavgationBarAndStatusBarHeight) collectionViewLayout:layout];
    _moveCollectionView.delegate = self;
    _moveCollectionView.dataSource = self;
    _moveCollectionView.backgroundColor = kGlobalBgColor;
    [_moveCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.view addSubview:_moveCollectionView];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(headleLongPress:)];
    [_moveCollectionView addGestureRecognizer:longPress];
    
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
    [cell.contentView addSubview:lab];
    return cell;
}
#pragma mark - 是否移动
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    //    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.photoArray];
    //数组里的个数必须和numberOfItemsInSection这个方法里的个数一致，否则移动到第一个或者最后一个，程序会崩溃
    NSString *string = [self.dataArray objectAtIndex:sourceIndexPath.row];
    [self.dataArray removeObject:string];
    [self.dataArray insertObject:string atIndex:destinationIndexPath.row];
}

- (void)headleLongPress:(UILongPressGestureRecognizer *)longGesture {
    //判断手势状态
    switch (longGesture.state) {
            case UIGestureRecognizerStateBegan: {
                NSIndexPath *indexPath = [self.moveCollectionView indexPathForItemAtPoint:[longGesture locationInView:self.moveCollectionView]];
                if (indexPath == nil) break;
                //在路径上则开始移动该路径上的cell
                [self.moveCollectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
            }
            break;
            
            case UIGestureRecognizerStateChanged: {
                //移动过程当中随时更新cell位置
                [self.moveCollectionView updateInteractiveMovementTargetPosition:[longGesture locationInView:self.moveCollectionView]];
            }
            break;
            
            case UIGestureRecognizerStateEnded: {
                //移动结束后关闭cell移动
                [self.moveCollectionView endInteractiveMovement];
            }
            break;
            
        default:
            [self.moveCollectionView cancelInteractiveMovement];
            break;
    }
}

@end
