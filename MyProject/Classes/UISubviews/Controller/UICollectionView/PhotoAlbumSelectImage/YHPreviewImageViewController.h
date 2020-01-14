//
//  YHPreviewImageViewController.h
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "YHBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YHPreviewImageViewController : YHBaseViewController

/**  文件夹里的照片  */
@property (nonatomic, strong) NSMutableArray<UIImage *> *previewImageArray;
/**   索引    */
@property (nonatomic, assign) NSInteger                  imageIndex;

@end

NS_ASSUME_NONNULL_END
