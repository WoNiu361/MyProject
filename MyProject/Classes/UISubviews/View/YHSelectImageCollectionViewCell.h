//
//  YHSelectImageCollectionViewCell.h
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHSelectImageModel;
@class YHSelectImageCollectionViewCell;
@class YHPHImageModel;

NS_ASSUME_NONNULL_BEGIN

@protocol YHSelectImageCollectionViewCellDelegate <NSObject>

- (void)selectImageWithCell:(YHSelectImageCollectionViewCell *)cell;
@end

@interface YHSelectImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView        *picImageView;

@property (nonatomic, strong) YHSelectImageModel *imageModel;

@property (nonatomic, weak) id<YHSelectImageCollectionViewCellDelegate>delegate;

@end

#pragma mark - 预览图片
@interface HRPreviewImageCollectionViewCell : UICollectionViewCell
/**  展示image  */
@property (nonatomic, strong) UIImageView           *showImageView;
/**  indexPath  */
@property (nonatomic, strong) NSIndexPath           *indexPath;
/**   手势点击    */
@property (nonatomic, copy) void(^singleTapActionBlcok)(UITapGestureRecognizer *singleTapGesture);
@property (nonatomic, copy) void(^doubleTapActionBlcok)(UITapGestureRecognizer *singleTapGesture);

- (void)resetZoomingScale;

- (void)resizeImageView;
@end



#pragma mark - 选中图片 - 预览底部view
@interface HRPriviewImageBottomView : UIView
/**  <#注释#>  */
@property (nonatomic, strong) UILabel *numberLabel;
/**  确定     */
@property (nonatomic, copy) dispatch_block_t sureBlcok;
/**   打开相册    */
@property (nonatomic, copy) dispatch_block_t openAlbumBlock;

/// 展示数据
/// @param title 标题
/// @param isHide 是否隐藏
- (void)showDataWithTitle:(NSString *)title hide:(BOOL)isHide;
/**   选择照片 按钮是否可以点击   */
- (void)changeColor:(BOOL)isChage;
@end



#pragma mark - 相册文件夹
@interface YHPhotoFolderView : UIView

- (instancetype)initWithFrame:(CGRect)frame folderArray:(NSMutableArray<YHPHImageModel *> *)folderModelArray;

@property (nonatomic,copy) void(^selectImageFolderBlock)(NSInteger idx);

- (void)showSubviews;

@end



#pragma mark - 文件夹
@interface YHPhotoCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) YHPHImageModel *model;

@end
NS_ASSUME_NONNULL_END
