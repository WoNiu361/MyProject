//
//  YHBaseView.m
//  MyProject
//
//  Created by 吕颜辉 on 2018/2/12.
//  Copyright © 2018 LYH-1140663172. All rights reserved.
//

#import "YHBaseView.h"

@implementation YHBaseView

- (instancetype)init {
    if (self = [super init]) {
        self.changeFrame =  NO;
    }
    return self;
}

- (void)dealloc{
    
    PPLog(@"=================%@Dealloc=================", NSStringFromClass([self class]));
}

+ (instancetype)viewFromNib {
    return [self viewFromNibWithIndex:0];
}

+ (instancetype)viewFromNibWithIndex:(NSInteger)index {
    NSArray * nibs = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil];
    if ([nibs count] <= index) {
        return nil;
    }
    id view = [nibs objectAtIndex:index];
    if (!view) {
        return nil;
    }
    return view;
}

- (void)setFrame:(CGRect)frame {
    if (self.changeFrame) {
        frame.origin.x = self.changeFrame ? kLeftSpace : 0;
        frame.size.width = frame.size.width - (self.changeFrame ?  kLeftSpace * 2 : 0);
    }
    [super setFrame:frame];
}

- (void)setBounds:(CGRect)bounds {
    if (self.changeFrame) {
        bounds.origin.x = self.changeFrame ? kLeftSpace : 0;
        bounds.size.width = bounds.size.width - (self.changeFrame ?  kLeftSpace * 2 : 0);
    }
    [super setBounds:bounds];
}


@end
