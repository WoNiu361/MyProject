//
//  HRShowSelectAlertView.m
//  taotaotuan-agent-ios
//
//  Created by LYH on 2019/7/22.
//  Copyright © 2019 LYH. All rights reserved.
//

#import "HRShowSelectAlertView.h"

@interface HRShowSelectAlertView ()<UITableViewDelegate,UITableViewDataSource>
/**    <#*#>   */
@property (nonatomic, strong) NSArray<NSString *> *titleArray;
@end
static NSString *const alertID = @"HRShowSelectAlertView";
@implementation HRShowSelectAlertView

- (instancetype)initWithFrame:(CGRect)frame
                        title:(NSString *)title
                   titleArray:(NSArray<NSString *> *)titleArray {
    if (self = [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4];
        self.titleArray = [NSArray arrayWithArray:titleArray];
        [self setupSubviewsWithTitle:title titleArray:titleArray];
    }
    return self;
}

- (void)setupSubviewsWithTitle:(NSString *)title titleArray:(NSArray<NSString *> *)titleArray {
    
    UIButton *cancelButton = [UIButton buttonWithLayer:8 withLayerWidth:.5 withLayerColor:[UIColor clearColor] withBgColor:[UIColor whiteColor] withTitle:title withTitleColor:kRGBColor(102, 102, 102) withTitleFont:18 withFrame:CGRectMake(kLeftSpace, MainScreenHeight - 8 - 57, MainScreenWidth - 2 * kLeftSpace, 57) withTarget:self withAction:@selector(clickButton:) weight:UIFontWeightRegular];
    [self addSubview:cancelButton];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.rowHeight = 57;
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.separatorColor = kRGBAColor(238,238,238,1.0);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = false;
    [self addSubview:tableView];
    tableView.sd_layout
    .leftEqualToView(cancelButton)
    .bottomSpaceToView(cancelButton, 8)
    .rightEqualToView(cancelButton)
    .heightIs(titleArray.count * 57);
    tableView.sd_cornerRadius = @(8);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:alertID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:alertID];
    }
    [self configureCell:cell indexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath {
    
    UILabel *titleLabel = [UILabel labelWithTitle:[self.titleArray objectAtIndex:indexPath.row] withTitleColor:kRGBAColor(251,94,121,1.0) withTitleFont:18 withFrame:CGRectMake(0, 0, MainScreenWidth - 2 * kLeftSpace, 57) withTextAligement:NSTextAlignmentCenter textWeigt:UIFontWeightRegular];
    if (indexPath.row == 0) {
        titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightBold];
        titleLabel.textColor = kRGBAColor(251,94,121,1.0);
    } else {
       titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightRegular];
        titleLabel.textColor = kRGBColor(102, 102, 102);
    }
    [cell addSubview:titleLabel];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self removeFromSuperview];
    if (self.delegate && [self.delegate respondsToSelector:@selector(view:selectPhotoWithTag:)]) {
        [self.delegate view:self selectPhotoWithTag:indexPath.row];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)clickButton:(UIButton *)sender {
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *myTouch = [touches anyObject];
    if ([myTouch.view isEqual:self]) {
        [self removeFromSuperview];
    }
}
@end
