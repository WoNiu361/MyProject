//
//  YHStringViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/31.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHStringViewController.h"

@interface YHStringViewController ()
/** 属性label */
@property (nonatomic, strong) UILabel *testLabel;
/** 多行显示 */
@property (nonatomic, strong) UILabel *linesLabel;
@end

@implementation YHStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"字符串知识";

    NSArray *pathArray = [NSArray arrayWithObjects:@"here", @"be", @"dragons", nil];
    MyLog(@"%@",[pathArray componentsJoinedByString:@""]);
    //2019-07-31 15:10:44.594082+0800 MyProject[4438:2378590] herebedragons
    
    //该方法的而作用是通过set来进行分割字符串，返回分割后的数组。
    //找到字符串中相等的字符串，并以数组形式展现出来，个数以字符串短的长度为准
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456"] invertedSet];
    NSString *nam = @"1g2h45j3d688";
    NSLog(@"invertedSet -  %@",[nam componentsSeparatedByCharactersInSet:set]);

    [self test];
    
    [self findNumber];
    
    [self richPropertyAboutString];
    
    // 睡到指定的时间
    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
    // 睡多久
    [NSThread sleepForTimeInterval:1.2];
}
 //找到字符串中不相等的字符串，并以数组形式展现出来，个数以字符串短的长度为准
- (void)test {
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"0123456"];
    NSString *nam = @"1g2h45j3d688";
    NSLog(@"set -  %@",[nam componentsSeparatedByCharactersInSet:set]);
}
#pragma mark - 找出相同的数字
- (void)findNumber {
    
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSString *nam = @"1g2h45j3d688";
    NSArray *arr = [nam componentsSeparatedByCharactersInSet:set];
    NSLog(@"number -  %@  \n %@",[arr componentsJoinedByString:@""],arr);

}

#pragma mark - 富文本属性
- (void)richPropertyAboutString{
    
    self.testLabel = [UILabel labelWithTitle:@"346 名" withTitleColor:[UIColor redColor] withTitleFont:36 withFrame:CGRectMake(10, 10, 200, 40) textWeigt:UIFontWeightMedium];
    [self.view addSubview:self.testLabel];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.testLabel.text];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[NSForegroundColorAttributeName] = [UIColor purpleColor];
    dic[NSFontAttributeName] = [UIFont systemFontOfSize:18];
    //    [attributedString addAttributes:@{NSForegroundColorAttributeName:[UIColor purpleColor],NSFontAttributeName:[UIFont systemFontOfSize:18]} range:NSMakeRange(3, self.testLabel.text.length - 3)];
    NSRange range = NSMakeRange(3, self.testLabel.text.length - 3);
    [attributedString addAttributes:dic range:range];
    self.testLabel.attributedText = attributedString;
    
    //文本内容多了需要计算高度
    //单行显示
    NSString *content = @"北京欢迎你";
    CGSize size = [content sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]}];
    MyLog(@"size---%f---%f",size.width,size.height);
    
    //多行显示
    NSString *textString = @"亲，欢迎您通过以下方式与我们的营销顾问取得联系，交流您再营销推广工作中遇到的问题，营销顾问将免费为您提供咨询服务。如果有问题，请咨询：1140663172@qq.com或者邮箱13733876213@163.com";
    CGSize contentSize = [textString boundingRectWithSize:CGSizeMake(MainScreenWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:15]} context:nil].size;

    self.linesLabel = [UILabel labelWithTitle:textString withTitleColor:[UIColor orangeColor] withTitleFont:15 withFrame:CGRectMake(self.testLabel.x, CGRectGetMaxY(self.testLabel.frame) + 5, MainScreenWidth - 2 * self.testLabel.x, contentSize.height) withTextAligement:NSTextAlignmentLeft textWeigt:UIFontWeightMedium];
    self.linesLabel.numberOfLines = 0;//多行显示，这句代码必不可少
    [self.view addSubview:self.linesLabel];
    
    //设置行间距
    NSMutableAttributedString *attributedString1 = [[NSMutableAttributedString alloc]initWithString:textString];
    NSMutableParagraphStyle *paragraphyStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphyStyle.lineSpacing = 10;
    paragraphyStyle.firstLineHeadIndent = 35;//首行文字缩进
    [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphyStyle range:NSMakeRange(0, [textString length])];
    self.linesLabel.attributedText = attributedString1;
    [self.linesLabel sizeToFit];
    
}

@end
