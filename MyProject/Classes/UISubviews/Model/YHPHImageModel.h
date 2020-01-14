//
//  YHPHImageModel.h
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHSelectImageModel;

NS_ASSUME_NONNULL_BEGIN

@interface YHPHImageModel : NSObject

/**   文件夹名称   */
@property (nonatomic, copy) NSString *photoAlbumName;
/**  相册中的图片 model */
@property (nonatomic, strong) NSMutableArray<YHSelectImageModel *> *phoneArray;

/**   图片文件加的位置，从0开始    */
@property (nonatomic, assign) NSInteger folderLocationIntger;
/**  文件夹里的照片  */
@property (nonatomic, strong) NSMutableArray<UIImage *> *imageArray;

@end



@interface YHSelectImageModel : NSObject

/**  <#注释#>  */
@property (nonatomic, strong) UIImage *img;
/**   <##>    */
@property (nonatomic, assign) BOOL isSelect;

/**   选中图片的数量    */
@property (nonatomic, assign) NSInteger selectAmount;

@end

NS_ASSUME_NONNULL_END
