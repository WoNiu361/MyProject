//
//  HRShowSelectAlertView.h
//  taotaotuan-agent-ios
//
//  Created by LYH on 2019/7/22.
//  Copyright © 2019 LYH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HRShowSelectAlertView;

typedef NS_ENUM(NSInteger,HeadImageFromSource) {
    HeadImageTakePhoto,                    //拍照
    HeadImageSelectPhotoLibrary,           //从相册选择
};

NS_ASSUME_NONNULL_BEGIN

@protocol HRShowSelectAlertViewDelegate <NSObject>

- (void)view:(HRShowSelectAlertView *)alertView selectPhotoWithTag:(NSInteger)tag;
@end

@interface HRShowSelectAlertView : UIView

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                   titleArray:(NSArray<NSString *> *)titleArray;

@property (nonatomic, weak) id<HRShowSelectAlertViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
