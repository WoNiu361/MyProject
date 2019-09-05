//
//  YHSelectIconTableViewCell.m
//  MyProject
//
//  Created by LYH on 2019/7/17.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHSelectIconTableViewCell.h"
#import "YHSelectModel.h"

@interface YHSelectIconTableViewCell ()

@property (nonatomic, strong) UILabel     *titleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;
@end
static NSString *const selectID = @"YHSelectIconTableViewCell";
@implementation YHSelectIconTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupSubviews];
    }
    return self;
}

+ (instancetype)setupSelectIconCellWithTableView:(UITableView *)tableView {
    
    YHSelectIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectID];
    if (cell == nil) {
        cell = [[YHSelectIconTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:selectID];
    }
    return cell;
}

- (void)setupSubviews {
    
    _titleLabel = [UILabel labelWithTitle:@"第一行" withTitleColor:kRGBColor(209,44,5) withTitleFont:15 withFrame:CGRectZero textWeigt:UIFontWeightMedium];
    _iconImageView = KImageView(@"unselect");
    
    [self.contentView sd_addSubviews:@[_titleLabel,_iconImageView]];
    
    _titleLabel.sd_layout
    .leftSpaceToView(self.contentView, kLeftSpace)
    .topSpaceToView(self.contentView, 0)
    .widthIs(MainScreenWidth / 3.0)
    .heightIs(self.contentView.height);
    
    _iconImageView.sd_layout
    .centerYEqualToView(_titleLabel)
    .rightSpaceToView(self.contentView, kLeftSpace)
    .widthIs(_iconImageView.image.size.width)
    .heightIs(_iconImageView.image.size.height);
}

-(void)setSelectModel:(YHSelectModel *)selectModel {
    
    _selectModel = selectModel;
    _titleLabel.text = selectModel.titleStr;
    if (selectModel.isSelect) {
        _iconImageView.image = kImageNamed(@"select");
    } else {
        _iconImageView.image = kImageNamed(@"unselect");
    }
}

@end
