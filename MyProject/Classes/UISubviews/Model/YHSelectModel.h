//
//  YHSelectModel.h
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHSelectModel : NSObject
/**  是否选中   */
@property (nonatomic, assign) BOOL     isSelect;
/**  cell上标题   */
@property (nonatomic, copy)   NSString *titleStr;
/**  区上标题   */
@property (nonatomic, copy)   NSString *headTitle;

@property (nonatomic, copy)   NSString *keyStr;
/** 是否展开 */
@property (nonatomic, assign) BOOL     isUnfold;

@end



@interface YHSelectStyleModel : NSObject

/**   title   */
@property (nonatomic, copy) NSString *title;
/**   pic   */
@property (nonatomic, copy) NSString *pic;
/**   isSelect    */
@property (nonatomic, assign) BOOL isSelect;

/**   标注的tagzhi    */
@property (nonatomic, assign) NSInteger markTag;

@end



NS_ASSUME_NONNULL_END
