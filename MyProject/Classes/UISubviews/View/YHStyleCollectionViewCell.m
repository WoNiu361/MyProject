//
//  YHStyleCollectionViewCell.m
//  MyProject
//
//  Created by LYH on 2019/7/30.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHStyleCollectionViewCell.h"
#import "YHSelectModel.h"

@interface YHStyleCollectionViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation YHStyleCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.contentView.userInteractionEnabled = true;
        self.contentView.layer.cornerRadius = 2;
        self.contentView.layer.masksToBounds = YES;
        self.contentView.layer.borderWidth = .5;
        self.contentView.layer.borderColor = kRGBColor(212,216,218).CGColor;
        
        _titleLabel = [UILabel labelWithTitle:@"我的测试" withTitleColor:kRGBColor(93,109,116) withTitleFont:15 withFrame:CGRectZero withTextAligement:NSTextAlignmentCenter textWeigt:UIFontWeightMedium];
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.bounds;
}

-(void)setSelectModel:(YHSelectModel *)selectModel {
    
    _selectModel = selectModel;
    _titleLabel.text = selectModel.titleStr;
    if (selectModel.isSelect) {
        self.contentView.backgroundColor = kRGBColor(255,181,133);
        self.contentView.layer.borderColor = kRGBColor(255,240,230).CGColor;
        _titleLabel.textColor =  kUIColorFromHEX(0xf1610a);
    } else {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.contentView.layer.borderColor = kRGBColor(212,216,218).CGColor;
        _titleLabel.textColor = kRGBColor(93,109,116);
    }
}
@end
