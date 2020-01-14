//
//  YHGooodsOperateStyleView.m
//  MyProject
//
//  Created by 吕颜辉 on 2020/1/14.
//  Copyright © 2020 LYH-1140663172. All rights reserved.
//

#import "YHGooodsOperateStyleView.h"
#import "YHSelectModel.h"
#import "UIButton+YHImageTitleSpacing.h"

@interface YHGooodsOperateStyleView ()
@property (nonatomic, strong) NSMutableArray<YHSelectStyleModel *> *titleModelArray;
@end

@implementation YHGooodsOperateStyleView

- (instancetype)initWithFrame:(CGRect)frame title:(NSMutableArray<YHSelectStyleModel *> *)titleArray {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleModelArray = [NSMutableArray arrayWithArray:titleArray];
        [self setupSubviewsWithTitle:titleArray];
        [KNotificationCenter addObserver:self selector:@selector(showSelectRank:) name:HRGoodsManageRank_Notification object:nil];
    }
    return self;
}

- (void)setupSubviewsWithTitle:(NSMutableArray<YHSelectStyleModel *> *)titleArray {
    
    CGFloat buttonWidth = MainScreenWidth / titleArray.count;
    [titleArray enumerateObjectsUsingBlock:^(YHSelectStyleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [UIButton buttonWithTitle:obj.title titleColor:kRGBColor(85, 85, 85) titleFont:13 frame:CGRectMake(idx * buttonWidth, 0, buttonWidth, self.height) target:self action:@selector(touchButton:)];
        [button setImage:[UIImage imageNamed:obj.pic] forState:0];
        [button setImage:kImageNamed(@"icon_up_expand") forState:UIControlStateSelected];
        [button layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
        button.tag = OperateStyleRank + idx;
        [button setTitleColor:kRGBColor(25, 137, 250) forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(touchButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
    }];
}

- (void)touchButton:(UIButton *)sender {
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull btn, NSUInteger idx, BOOL * _Nonnull stop) {
        if (sender != btn) {
            btn.selected = false;
        }
        if (btn.tag == OperateStyleWholeEdit) {
            [btn setImage:kImageNamed(@"") forState:0];
        }
    }];
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        PPLog(@"1-1-1--1111");
        if (sender.tag == OperateStyleWholeEdit) {//批量 处理，只改变文字颜色，不显示图片
            [sender setImage:kImageNamed(@"") forState:UIControlStateSelected];
        }
        if (self.delegate && [self.delegate respondsToSelector:@selector(view:clickButtonWithTag:selectState:)]) {
            [self.delegate view:self clickButtonWithTag:sender.tag selectState:sender.selected ? @"1" : @"0"];
        }
        
    } else {
        PPLog(@"909090----");
        if (sender.tag == OperateStyleWholeEdit) {//批量 处理，只改变文字颜色，不显示图片
            [sender setImage:kImageNamed(@"") forState:0];
        }
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(view:clickButtonWithTag:selectState:)]) {
            [self.delegate view:self clickButtonWithTag:sender.tag selectState:sender.selected ? @"1" : @"0"];
        }
    }
}

#pragma mark - 让按钮置于初始位置
- (void)makeButtonInitialState {
    
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = (UIButton *)obj;
        btn.selected = false;
        if (btn.tag == OperateStyleWholeEdit) {//批量 处理，只改变文字颜色，不显示图片
            [btn setImage:kImageNamed(@"") forState:0];
        }
    }];
}
#pragma mark - 通知，选择排序类型、点击空白处收起排序，
- (void)showSelectRank:(NSNotification *)notification {

    NSString *rankStr = notification.userInfo[HRShowSelectRankStyle];
    PPLog(@"rankStr -  %@",rankStr);
    [self makeButtonInitialState];
    /**
     点击空白处和点击排序列表公用一个通知名称-HRShowSelectRankStyle，但是字典里的参数不一样：
     点击空白处，字典里的参数是 key是HRShowSelectRankStyle，value是HRShowSelectRankStyle，
     //点击空白处了，收回排序列表，且类型列表复位
     
     点击排序列表，字典里的参数是 key是HRShowSelectRankStyle，value是排序的内容，收回排序列表，且类型列表复位
     */
    if (![rankStr isEqualToString:HRShowSelectRankStyle]) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = (UIButton *)obj;
            if (btn.tag == OperateStyleRank) {
                [btn setTitle:rankStr forState:UIControlStateNormal];
                [btn layoutButtonWithEdgeInsetsStyle:MKButtonEdgeInsetsStyleRight imageTitleSpace:5];
            }
        }];
    }
}

@end





@interface YHStyleRankView ()<UITableViewDelegate,UITableViewDataSource>
/**  <#注释#>  */
@property (nonatomic, strong) UIView                               *bgView;
/**  <#注释#>  */
@property (nonatomic, strong) UITableView                          *rankTableView;
/**  <#注释#>  */
@property (nonatomic, strong) NSMutableArray<YHSelectStyleModel *> *rankModelArray;
@end

@implementation YHStyleRankView

- (instancetype)initWithFrame:(CGRect)frame titleArray:(NSMutableArray<YHSelectStyleModel *> *)rankModelArray {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [kRGBColor(46, 44, 44) colorWithAlphaComponent:0.3];
        self.rankModelArray = [NSMutableArray arrayWithArray:rankModelArray];
        [self setupSubviewsWithArray:rankModelArray];
    }
    return self;
}

- (void)setupSubviewsWithArray:(NSMutableArray<YHSelectStyleModel *> *)rankModelArray {
    
    CGFloat itemHeight = 42.0;
    _bgView = [UIView viewWithBackgroundColor:[UIColor whiteColor] frame:CGRectMake(0, 0, MainScreenWidth, itemHeight * rankModelArray.count)];
    [self addSubview:_bgView];
    _bgView.layer.mask = [[YHShareInstance shareInstance] masksToBoundsWithFrame:CGRectMake(0, 0, MainScreenWidth, _bgView.height) rectCorner:UIRectCornerBottomLeft | UIRectCornerBottomRight size:CGSizeMake(16, 16)];
    
    _rankTableView = [[UITableView alloc] initWithFrame:_bgView.bounds style:UITableViewStylePlain];
    _rankTableView.delegate = self;
    _rankTableView.dataSource = self;
    _rankTableView.rowHeight = itemHeight;
    _rankTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _rankTableView.separatorColor = kGlobalBgColor;
    [_bgView addSubview:_rankTableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rankModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const rankID = @"UITableViewCell_rank";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rankID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:rankID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj performSelector:@selector(removeFromSuperview)];
    }];
    YHSelectStyleModel *model = self.rankModelArray[indexPath.row];
    UILabel *lab = [UILabel labelWithTitle:model.title withTitleColor:kRGBColor(119, 119, 199) withTitleFont:13 withFrame:CGRectMake(30 * SizeScaleX, 0, MainScreenWidth/2.0, 42.0) textWeigt:UIFontWeightRegular];
    [cell.contentView addSubview:lab];
    model.isSelect ? (lab.textColor = kRGBColor(25,137,250)) : (lab.textColor = kRGBColor(119, 119, 119));
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHSelectStyleModel *selectModel = self.rankModelArray[indexPath.row];
    [self.rankModelArray enumerateObjectsUsingBlock:^(YHSelectStyleModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqual:selectModel]) {
            obj.isSelect = true;
        } else {
            obj.isSelect = false;
        }
    }];
    [_rankTableView reloadData];
    [self removeFromSuperview];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:selectModel.title forKey:HRShowSelectRankStyle];
    [KNotificationCenter postNotificationName:HRGoodsManageRank_Notification object:nil userInfo:dic];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat space = 24 * SizeScaleX;
    if ([_rankTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_rankTableView setSeparatorInset:UIEdgeInsetsMake(0, space, 0, space)];
    }
    if ([_rankTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_rankTableView setLayoutMargins:UIEdgeInsetsMake(0, space, 0, space)];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIView *touchView = [touches anyObject].view;
    if ([touchView isKindOfClass:[self class]]) {
        [self removeFromSuperview];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:HRShowSelectRankStyle forKey:HRShowSelectRankStyle];
    [KNotificationCenter postNotificationName:HRGoodsManageRank_Notification object:nil userInfo:dic];
}

- (void)showRankData {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    _bgView.transform = CGAffineTransformMakeScale(0.001,0.001);
    [UIView animateWithDuration:.35 animations:^{
        self->_bgView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
}

@end
