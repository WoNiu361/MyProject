//
//  YHSelectImageCollectionViewCell.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "YHSelectImageCollectionViewCell.h"
#import "YHPHImageModel.h"

@interface YHSelectImageCollectionViewCell ()
/**  <#注释#>  */
@property (nonatomic, strong) UIButton *showSelectButton;
/**  显示数量的  */
@property (nonatomic, strong) UILabel  *numberLabel;
/**  <#注释#>  */
@property (nonatomic, strong) UIView   *coverView;
@end

@implementation YHSelectImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    _picImageView = [UIImageView imageViewWithImage:@"default" frame:CGRectZero];
    _picImageView.userInteractionEnabled = true;
    [self.contentView addSubview:_picImageView];
    
    _coverView = [UIView viewWithBackgroundColor:[kRGBColor(51, 51, 51) colorWithAlphaComponent:0.5] frame:self.contentView.bounds];
    
    [self.contentView addSubview:_coverView];
    
    _showSelectButton = [UIButton buttonWithImage:@"unselectImage" withFrame:CGRectZero withTarget:self withAction:@selector(selectImage:)];
    [self.contentView addSubview:_showSelectButton];
    
    [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
    }];
    
    [_showSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
//        make.centerX.equalTo(self.contentView.mas_centerX);
//        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.equalTo(@(_showSelectButton.currentImage.size.width * 1.5));
        make.height.equalTo(@(_showSelectButton.currentImage.size.height * 1.5));
    }];
    
    _numberLabel = [UILabel labelWithTitle:@"" withTitleColor:[UIColor whiteColor] withTitleFont:16 withFrame:CGRectZero withTextAligement:NSTextAlignmentCenter textWeigt:UIFontWeightBold];
    [_showSelectButton addSubview:_numberLabel];
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_showSelectButton.mas_centerX);
        make.centerY.equalTo(_showSelectButton.mas_centerY);
        make.width.equalTo(@(_showSelectButton.currentImage.size.width));
        make.height.equalTo(@(_showSelectButton.currentImage.size.height));
    }];
}

-(void)setImageModel:(YHSelectImageModel *)imageModel {
    
    _imageModel = imageModel;
    _picImageView.image = imageModel.img;
    if (imageModel.selectAmount > 0) {
        [_showSelectButton setImage:kImageNamed(@"selectImage") forState:0];
        _numberLabel.text = [NSString stringWithFormat:@"%ld",imageModel.selectAmount];
        _coverView.hidden = false;
    } else {
         [_showSelectButton setImage:kImageNamed(@"unselectImage") forState:0];
        _numberLabel.text = @"";
        _coverView.hidden = true;
    }
}

- (void)selectImage:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectImageWithCell:)]) {
        [self.delegate selectImageWithCell:self];
    }
}

@end




@interface HRPreviewImageCollectionViewCell ()<UIScrollViewDelegate>
/**  <#注释#>  */
@property (nonatomic, strong) UIScrollView          *imageScrollView;

@property (nonatomic,strong) UITapGestureRecognizer *doubleTap;

@property (nonatomic,strong) UITapGestureRecognizer *singleTap;
@end

@implementation HRPreviewImageCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    [self addSubview:self.imageScrollView];
    [self.imageScrollView addSubview:self.showImageView];
    
    [self addGestureRecognizer:self.singleTap];
    [self addGestureRecognizer:self.doubleTap];
}

- (void)resetZoomingScale {
    
    if (self.imageScrollView.zoomScale !=1) {
         self.imageScrollView.zoomScale = 1;
    }
}


- (void)resizeImageView {
    CGSize size = self.showImageView.image.size;
    CGFloat scale = size.height / size.width;
    BOOL flag = scale > MainScreenHeight / MainScreenWidth;
    if (size.height > MainScreenHeight * 2 && flag) {
        CGFloat height = MainScreenWidth * size.height / size.width;
        self.showImageView.frame = CGRectMake(0, 0, MainScreenWidth, height);
    } else {
        self.showImageView.frame = self.imageScrollView.bounds;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imageScrollView.frame = self.bounds;
    self.showImageView.frame = self.imageScrollView.bounds;
}
#pragma mark UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.showImageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    self.showImageView.center = [self centerOfScrollViewContent:scrollView];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    [[NSNotificationCenter defaultCenter] postNotificationName:HRPhotoCellDidZomming_Notification object:_indexPath];
}

#pragma mark - 手势处理
- (void)singleTapGestrueHandle:(UITapGestureRecognizer *)tap {//单击
    if (self.singleTapActionBlcok) {
        self.singleTapActionBlcok(tap);
    }
}

- (void)doubleTapGestrueHandle:(UITapGestureRecognizer *)tap {//双击放大图片
    
    if (self.doubleTapActionBlcok) {
        self.doubleTapActionBlcok(tap);
    }
    
    CGPoint point = [tap locationInView:self];
    if (self.imageScrollView.zoomScale <= 1.0) {
        CGRect rect = [self zoomRectForScale:self.imageScrollView.zoomScale * 3 withCenter:point];
        [self.imageScrollView zoomToRect:rect animated:YES];
    } else {
        [self.imageScrollView setZoomScale:1.0 animated:YES];
    }
}


#pragma mark - private
- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center {
    CGRect zoomRect;
    zoomRect.size.height = self.imageScrollView.frame.size.height/scale;
    zoomRect.size.width = self.imageScrollView.frame.size.width/scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width/2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height/2.0);
    
    return zoomRect;
    
}

- (CGPoint)centerOfScrollViewContent:(UIScrollView *)scrollView {
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    CGPoint actualCenter = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                       scrollView.contentSize.height * 0.5 + offsetY);
    return actualCenter;
}
#pragma mark - lazy
-(UIScrollView *)imageScrollView {
    if (_imageScrollView == nil) {
        _imageScrollView = [[UIScrollView alloc] initWithFrame:self.contentView.bounds];
        _imageScrollView.backgroundColor = [UIColor whiteColor];
        _imageScrollView.showsVerticalScrollIndicator = false;
        _imageScrollView.showsHorizontalScrollIndicator = false;
        _imageScrollView.maximumZoomScale = 4;
        _imageScrollView.minimumZoomScale = 0.5;
        _imageScrollView.delegate = self;
    }
    return _imageScrollView;
}

-(UIImageView *)showImageView {
    if (_showImageView == nil) {
        _showImageView = [[UIImageView alloc] init];
        _showImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _showImageView;
}

-(UITapGestureRecognizer *)singleTap {
    if (_singleTap == nil) {
        _singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapGestrueHandle:)];
        _singleTap.numberOfTouchesRequired = 1; //需要几根手指点击
        _singleTap.numberOfTapsRequired = 1; //点击几下
    }
    return _singleTap;
}

-(UITapGestureRecognizer *)doubleTap {
    if (_doubleTap == nil) {
        _doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapGestrueHandle:)];
        _doubleTap.numberOfTouchesRequired = 1;
        _doubleTap.numberOfTapsRequired = 2;
    }
    return _doubleTap;
}


@end




@interface HRPriviewImageBottomView ()
/**   <##>   */
@property (nonatomic, weak) UIControl *control;
/**   <##>   */
@property (nonatomic, weak) UIButton *selectButton;
@end

@implementation HRPriviewImageBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [kRGBColor(51, 51, 51) colorWithAlphaComponent:0.9];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    _numberLabel = [UILabel labelWithTitle:@"0/9" withTitleColor:[UIColor whiteColor] withTitleFont:14 withFrame:CGRectZero textWeigt:UIFontWeightRegular];
//    _numberLabel.hidden = true;
    [self addSubview:_numberLabel];
    
    UIButton *selectButton = [UIButton buttonWithLayer:16 withLayerWidth:0.01 withLayerColor:[UIColor clearColor] withBgColor:[UIColor clearColor] withTitle:@"确定" withTitleColor:[UIColor whiteColor] withTitleFont:14 withFrame:CGRectZero withTarget:self withAction:@selector(sureImage:) weight:UIFontWeightRegular];
    [self addSubview:selectButton];
    self.selectButton = selectButton;
    
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kLeftSpace);
        make.top.equalTo(self.mas_top).offset(20);
        make.height.equalTo(@20);
        make.width.equalTo(@(MainScreenWidth / 4.0));
    }];
    
    [selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_numberLabel);
        make.right.equalTo(self.mas_right).offset(-20 * SizeScaleX);
        make.width.equalTo(@(64 * SizeScaleX));
        make.height.equalTo(@32);
    }];
    UIImage *img = [[YHShareInstance shareInstance] gradientImageWithColors:@[kRGBColor(58, 153, 250),kRGBColor(27, 138, 250),kRGBColor(25, 137, 250)] rect:CGRectMake(0, 0, 64 * SizeScaleX, 32)];
    [selectButton setBackgroundImage:img forState:0];
    
    UIControl *control = [[UIControl alloc] initWithFrame:CGRectZero];
    [control addTarget:self action:@selector(openAlbum:) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:control];
    self.control = control;
    [control mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(kLeftSpace);
        make.top.equalTo(self.mas_top).offset(20);
        make.height.equalTo(@20);
        make.width.equalTo(@(MainScreenWidth / 4.0));
    }];
}

- (void)sureImage:(UIButton *)sender {
    if (self.sureBlcok) {
        self.sureBlcok();
    }
}

- (void)openAlbum:(UIControl *)sender {
    if (self.openAlbumBlock) {
        self.openAlbumBlock();
    }
}

- (void)showDataWithTitle:(NSString *)title hide:(BOOL)isHide {
    
    _numberLabel.text = title;
    if (isHide) {// 预览 进来，可以点击
        UIImage *img = [[YHShareInstance shareInstance] gradientImageWithColors:@[kRGBColor(58, 153, 250),kRGBColor(27, 138, 250),kRGBColor(25, 137, 250)] rect:CGRectMake(0, 0, 64 * SizeScaleX, 32)];
        [self.selectButton setBackgroundImage:img forState:0];
        self.control.enabled = false;
        [self.selectButton setTitleColor:[UIColor whiteColor] forState:0];
    } else { //选择图片进来，默认按钮是灰色的，不可点击
         UIImage *img = [[YHShareInstance shareInstance] gradientImageWithColors:@[kRGBColor(153, 153, 153),kRGBColor(153, 153, 153),kRGBColor(153, 153, 153)] rect:CGRectMake(0, 0, 64 * SizeScaleX, 32)];
        [self.selectButton setBackgroundImage:img forState:0];
        self.control.enabled = true;
        [self.selectButton setTitleColor:kRGBColor(85, 85, 85) forState:0];
    }
}

- (void)changeColor:(BOOL)isChage {
    if (isChage) {//选中照片，显示l蓝色，可以点击
        UIImage *img = [[YHShareInstance shareInstance] gradientImageWithColors:@[kRGBColor(58, 153, 250),kRGBColor(27, 138, 250),kRGBColor(25, 137, 250)] rect:CGRectMake(0, 0, 64 * SizeScaleX, 32)];
        [self.selectButton setBackgroundImage:img forState:0];
        self.selectButton.enabled = true;
        [self.selectButton setTitleColor:[UIColor whiteColor] forState:0];
    } else {//没有照片可选中，是灰色，不可点击
        UIImage *img = [[YHShareInstance shareInstance] gradientImageWithColors:@[kRGBColor(153, 153, 153),kRGBColor(153, 153, 153),kRGBColor(153, 153, 153)] rect:CGRectMake(0, 0, 64 * SizeScaleX, 32)];
        [self.selectButton setBackgroundImage:img forState:0];
        self.selectButton.enabled = false;
        [self.selectButton setTitleColor:kRGBColor(85, 85, 85) forState:0];
    }
}
@end





@interface YHPhotoFolderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
/**  <#注释#>  */
@property (nonatomic, strong) NSMutableArray<YHPHImageModel *> *folderModelArray;
/**  背景  */
@property (nonatomic, strong) UIView                           *bgView;
@end
static NSString *const folderID = @"YHPhotoCollectionViewCell_folder";
@implementation YHPhotoFolderView

- (instancetype)initWithFrame:(CGRect)frame folderArray:(NSMutableArray<YHPHImageModel *> *)folderModelArray {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [kRGBColor(46, 44, 44) colorWithAlphaComponent:0.9];
        self.frame = [UIScreen mainScreen].bounds;
        self.folderModelArray = [NSMutableArray arrayWithArray:folderModelArray];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    CGFloat itemWidth = (MainScreenWidth - 3 * kLeftSpace)/3.0;
    CGFloat lineSpace = 10.0;
    
    CGFloat collectionViewHeight = [self getCollectionViewHeightWithCount:self.folderModelArray.count itemWidth:itemWidth + 25 lineSpace:lineSpace] + 10;
    
    _bgView = [UIView viewWithBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0.9] frame:CGRectMake(0, MainScreenHeight - kSafeAreaHeight - collectionViewHeight - 40, MainScreenWidth, collectionViewHeight + kSafeAreaHeight + 40)];
    [self addSubview:_bgView];
    _bgView.layer.mask = [[YHShareInstance shareInstance] masksToBoundsWithFrame:CGRectMake(0, 0, MainScreenWidth, collectionViewHeight + kSafeAreaHeight + 40) rectCorner:UIRectCornerTopLeft | UIRectCornerTopRight size:CGSizeMake(16, 16)];
    
   UIButton *cancelButton = [UIButton buttonWithImage:@"closePhotoAlbum" withFrame:CGRectZero withTarget:self withAction:@selector(cancelPhotoFolder:)];
    [_bgView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_bgView.mas_right).offset(-kLeftSpace);
        make.top.equalTo(_bgView.mas_top).offset(8);
        make.width.equalTo(@24);
        make.height.equalTo(cancelButton.mas_width);
    }];
  
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    layout.minimumLineSpacing = lineSpace;
    layout.minimumInteritemSpacing = 5;
    
    UICollectionView *folderCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, MainScreenWidth, collectionViewHeight) collectionViewLayout:layout];
    folderCollectionView.backgroundColor = [UIColor clearColor];
    folderCollectionView.delegate = self;
    folderCollectionView.dataSource = self;
    [folderCollectionView registerClass:[YHPhotoCollectionViewCell class] forCellWithReuseIdentifier:folderID];
    [_bgView addSubview:folderCollectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.folderModelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YHPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:folderID forIndexPath:indexPath];
    cell.model = [self.folderModelArray objectAtIndex:indexPath.item];
    return cell;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, kLeftSpace, 0, kLeftSpace);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.selectImageFolderBlock) {
        self.selectImageFolderBlock(indexPath.item);
        [self removeFromSuperview];
    }
}
#pragma mark - 取消相册
- (void)cancelPhotoFolder:(UIButton *)sender {
    [self removeFromSuperview];
}

#pragma mark - 获取collectionView的高度
- (CGFloat)getCollectionViewHeightWithCount:(NSInteger)count
                                  itemWidth:(CGFloat)itemWidth
                                  lineSpace:(CGFloat)lineSpace {
    
    CGFloat sumH = 0;
    NSInteger row = count /  3;
    row = (count % 3) > 0 ? row + 1 : row;
    sumH = itemWidth * row + lineSpace * (row - 1);
    return sumH;
}

- (void)showSubviews {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _bgView.transform = CGAffineTransformMakeScale(0.001, 0.001);
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self->_bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

@end



@interface YHPhotoCollectionViewCell ()
/**  <#注释#>  */
@property (nonatomic, strong) UIImageView *photoImageView;
/**  <#注释#>  */
@property (nonatomic, strong) UILabel     *titleLabel;
@end

@implementation YHPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
    self.photoImageView = [UIImageView imageViewWithImage:@"default" frame:CGRectZero];
    self.photoImageView.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:self.photoImageView];
    
    _titleLabel = [UILabel labelWithTitle:@"支付宝" withTitleColor:kRGBColor(51, 51, 51) withTitleFont:14 withFrame:CGRectZero withTextAligement:NSTextAlignmentCenter textWeigt:UIFontWeightMedium];
    [self.contentView addSubview:_titleLabel];
    
    [self.photoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.top.and.right.equalTo(self.contentView).offset(0);
        make.height.equalTo(self.photoImageView.mas_width);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.top.equalTo(self.photoImageView.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(20);
    }];
}

-(void)setModel:(YHPHImageModel *)model {
    
    _model = model;
//    PPLog(@"model.imageArray -   %@",model.phoneArray);
    _titleLabel.text = model.photoAlbumName;
    YHSelectImageModel *imageModel = model.phoneArray[0];
    _photoImageView.image = imageModel.img;
}

@end

