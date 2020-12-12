//
//  YHBaseTableViewCell.m
//  MyProject
//
//  Created by 吕颜辉 on 2018/2/12.
//  Copyright © 2018 LYH-1140663172. All rights reserved.
//

#import "YHBaseTableViewCell.h"

@implementation YHBaseTableViewCell

- (instancetype)init {
    if (self = [super init]) {
        self.changeFrame =  NO;
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    
}

- (void)setFrame:(CGRect)frame {
    
    frame.origin.x = self.changeFrame ? kLeftSpace : 0;
    frame.size.width = frame.size.width - (self.changeFrame ?  kLeftSpace * 2 : 0);
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    
    bounds.origin.x = self.changeFrame ? kLeftSpace : 0;
    bounds.size.width = bounds.size.width - (self.changeFrame ?  kLeftSpace * 2 : 0);
    [super setBounds:bounds];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
