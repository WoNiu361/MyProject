//
//  YHDateViewController.m
//  MyProject
//
//  Created by LYH on 2019/8/1.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHDateViewController.h"

@interface YHDateViewController ()
@property (nonatomic, weak)   UILabel     *stampLabel;
@end

@implementation YHDateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"时间";
    
     UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, 200, 30)];
    label.text = [self timeStampChangeDate:@"1471231526" dateFormatter:@"YYYY-MM-dd"];
    [self.view addSubview:label];
    
    [self getCurrentDateWithFromatter:@"YYYY-MM-dd HH:mm:ss"];
    
    [self acquiryCurrentMonthFirstDay];
}
#pragma mark - 时间戳转成时间
/**
 时间戳转成时间

 @param timeStamp 时间戳
 @param dateFromatter 时间类型 eg: YYYY-MM-dd HH:mm:ss,YYYY-MM-dd
 @return 时间
 */
- (NSString *)timeStampChangeDate:(NSString *)timeStamp dateFormatter:(NSString *)dateFromatter {
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    formatter.dateFormat = dateFromatter;
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeStamp floatValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}

#pragma mark - 获取当前时间
/**
 获取当前时间

 @param foramtter 时间类型
 @return 时间
 */
- (NSString *)getCurrentDateWithFromatter:(NSString *)foramtter {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:foramtter];
    NSString *currentTime = [formatter stringFromDate:[NSDate date]];
    MyLog(@"currentTime-----%@",currentTime);
    
    NSString *yearStr = [currentTime substringToIndex:4];
    MyLog(@"yearStr-----%@",yearStr);
    
    NSString *monthStr = [currentTime substringWithRange:NSMakeRange(5, 2)];
    MyLog(@"monthStr----%@",monthStr);
    
    NSString *dayStr = [currentTime substringWithRange:NSMakeRange(8, 2)];
    MyLog(@"dayStr----%@",dayStr);
    
    NSString *curentTimeStr = [NSString stringWithFormat:@"%@-%@-%@",yearStr,monthStr,dayStr];
    
    return curentTimeStr;
}
#pragma mark - 获取当前月第一天
- (NSString *)acquiryCurrentMonthFirstDay {
    
    NSDate *currentDate = [NSDate date];
    MyLog(@"currentDate -  %@",currentDate);
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDate *firstDate = [calendar startOfDayForDate:currentDate];
//    MyLog(@"firstDate -    %@",firstDate);
    
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth fromDate:currentDate];
    [components setDay:1];
    [components setHour:+8];
    MyLog(@"0- 0 -0   %@",[calendar dateFromComponents:components]);

    NSString *string = [NSString stringWithFormat:@"%@",[calendar dateFromComponents:components]];
    MyLog(@"string -   %@",string);
    NSString *currentMonthFirstDay = [string substringToIndex:10];
    NSLog(@"currentMonthFirstDay----%@",currentMonthFirstDay);
    
    return @"";
}
@end
