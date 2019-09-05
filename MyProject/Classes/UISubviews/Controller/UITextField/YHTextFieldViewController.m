//
//  YHTextFieldViewController.m
//  MyProject
//
//  Created by LYH on 2019/7/30.
//  Copyright © 2019 LYH-1140663172. All rights reserved.
//

#import "YHTextFieldViewController.h"
#import "YHBaseTextField.h"
#import <objc/runtime.h>

@interface YHTextFieldViewController ()<UITextFieldDelegate>

@end

@implementation YHTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MyLog(@"viewDidLoad -- ");
    self.title = @"UITextField知识";
    
    YHBaseTextField *textField = [[YHBaseTextField alloc] initWithFrame:CGRectMake(50, 50, 300, 50) imageName:@"checkCode" placeholder:@"请输入..." placeHolderFont:15 placeHolderColor:[UIColor redColor]];
    textField.delegate = self;
    //这里设置为无文字就灰色不可点
    textField.enablesReturnKeyAutomatically = true;
    //实时监控输入内容的变化
    [textField addTarget:self action:@selector(textChange:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:textField];
    
}
#pragma mark - 输入框内容的变化，配合shouldChangeCharactersInRange方法，可以控制输入的位数
- (void)textChange:(UITextField *)textField {
    
}
#pragma mark - 获取私有属性
+ (void)initialize {
    MJRefreshLog(@"initialize --- ");
    
    unsigned int count = 0;
    //运用runtime来查找属性
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    for (int i = 0; i < count; i ++) {
        Ivar ivar = ivars[i];
        MyLog(@"ivar --  %s,---%s",ivar_getName(ivar),ivar_getTypeEncoding(ivar));
    }
}
/**
 每当用户操作导致文本发生更改时，文本字段都会调用此方法.
 这个方法里，拿到的textField.text的内容不是真实的值，有可能会缺少字符串（当你删除时你就会看到的，内容删除完了，但是此处的textField.text还有值）；
 这个方法里可以判断你输入的内容的位数，例如 登录时的电话号码，输入数字的位数；
 

 @param textField textField.text的内容比输入框显示的少了个字符串，就是这里的string的内容.在这里后去的不是真的值
 @param range range.location从0开始，被代替的文本的range UITextField控件中光标选中的字符串，即被替换的字符串；
 　　　　　　    range.length为0时，表示在位置range.location插入string。
 @param string 文本输入的最后一个值  替换字符串,    string.length为0时，表示删除。
 @return NO禁止输入任何文本，YES可以输入改变的文本
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    MJRefreshLog(@"textField.text -  %@ \n --- string %@ \n --  %lu -   \n   %lu  \n %ld",textField.text,string,(unsigned long)range.location,(unsigned long)range.length,string.length);
    MyLog(@"rang -    %@",NSStringFromRange(range));
      NSInteger inputCount = textField.text.length - range.length + string.length;
    if (inputCount > 11) { //判断输入的位数，多用来输入账号、密码
        return false;
    }
    
    
//    return [self judgeTextFieldInputDecimals:textField replacementString:string shouldChangeCharactersInRange:range];
//    return [self inputJudge:textField replacementString:string shouldChangeCharactersInRange:range];
    
  //  第一个：用来验证只能输入数字：
//    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
//    NSString *filterStr = [[string componentsSeparatedByCharactersInSet:set] componentsJoinedByString:@""];
//    if ([string isEqualToString:filterStr]) {
//        MyLog(@"111111");
//        return YES;
//    } else {
//        return false;
//    }
//     MyLog(@"00000");
    return true;
}

/*
 typedef struct _NSRange {
 NSUInteger location;
 NSUInteger length;
 } NSRange;
 */

/**
 当你按下清除按钮时，是否清除输入框的内容

 @param textField textField
 @return yes 清除，no不清除
 */
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return true;
}

/**
 called when 'return' key pressed. return NO to ignore.
 当你的键盘为默认的键盘时，右下角有个 返回按钮，点击返回按钮是否允许有操作，YES有操作，NO没有。比如搜索，右下角这个返回按钮可以设置为搜索，点击搜索做进一步操作。

 @param textField textField
 @return 是否响应reutrn按钮
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    MJRefreshLog(@"textField -   %@",textField.text);
    return true;
}

/**
 是否允许开始编辑
 在这里打印textField.text，只会打印出你刚刚编辑的之前的值，是个空值。当你再次点击时，才会打印出你上次编辑的值

 @param textField textField
 @return YES允许开始编辑，并且弹出键盘，NO不允许开始编辑，点击没有反应，不会弹出键盘
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    MyLog(@"textFieldShouldBeginEditing -   %@",textField.text);
    return true;
}

/**
 是否允许结束编辑。当你停止编辑时，这个时候还不能打印出输入的内容，在[self.view endEditing:YES]；点击空白处才会打印出你输入的内容。

 @param textField textField
 @return YES允许结束编辑切点击空白处可以收回键盘 [self.view endEditing:YES]，并且失去第一响应;NO不允许结束编辑编辑，键盘不会回收。但是YES /NO都会点击空白处会输出输入的内容
 */
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    MyLog(@"textFieldShouldEndEditing -   %@",textField.text);
    return true;
}

/**
 结束编辑，当你停止编辑时，这个时候还不能打印出输入的内容，在[self.view endEditing:YES]；点击空白处才会打印出你输入的内容。

 @param textField textField
 */
- (void)textFieldDidEndEditing:(UITextField *)textField {
    MyLog(@"textFieldDidEndEditing - %@",textField.text);
}


/**
 开始编辑。在这里打印textField.text，只会打印出你刚刚编辑的之前的值，是个空值。当你再次点击时，才会打印出你上次编辑的值

 @param textField textField
 */
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    MyLog(@"textFieldDidBeginEditing -  %@",textField.text);
}

//- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
//
//}

#pragma mark - 判断输入的内容小数点后俩位，
- (BOOL)judgeTextFieldInputDecimals:(UITextField *)textField
                  replacementString:(NSString *)string
      shouldChangeCharactersInRange:(NSRange)range {
    
    // 1 不能直接输入小数点
    if ( [textField.text isEqualToString:@""] && [string isEqualToString:@"."] )  return NO;
    
    // 2 输入框第一个字符为“0”时候，第二个字符如果不是“.”,那么文本框内的显示内容就是新输入的字符[textField.text length] == 1  防止例如0.5会变成5
    NSRange zeroRange = [textField.text rangeOfString:@"0"];
    if(zeroRange.length == 1 && [textField.text length] == 1 && ![string isEqualToString:@"."]){
        textField.text = string;
        return NO;
    }
    
    // 3 保留两位小数
    NSUInteger remain = 2;
    NSRange pointRange = [textField.text rangeOfString:@"."];
    
    // 拼接输入的最后一个字符
    NSString *tempStr = [textField.text stringByAppendingString:string];
    NSUInteger strlen = [tempStr length];
    
    // 输入框内存在小数点， 不让再次输入“.” 或者 总长度-包括小数点之前的长度>remain 就不能再输入任何字符
    if(pointRange.length > 0 &&([string isEqualToString:@"."] || strlen - (pointRange.location + 1) > remain))
        return NO;
    
    // 4 小数点已经存在情况下可以输入的字符集  and 小数点还不存在情况下可以输入的字符集
    NSCharacterSet *numbers = (pointRange.length > 0)?[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] : [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    NSString *buffer;
    // 判断string在不在numbers的字符集合内
    BOOL scan = [scanner scanCharactersFromSet:numbers intoString:&buffer];
    
    if ( !scan && ([string length] != 0) )  // 包括输入空格scan为NO， 点击删除键[string length]为0
    {
        return NO;
    }
    return YES;
}
#pragma mark - 判断输入的内容小数点后俩位且第一位可以输入0
- (BOOL)inputJudge:(UITextField *)textField
 replacementString:(NSString *)string
shouldChangeCharactersInRange:(NSRange)range {
    
    //小数点前6位，小数点后2位
    // 当前输入的字符是'.'
    if ([string isEqualToString:@"."]) {
        // 已输入的字符串中已经包含了'.'或者""
        if ([textField.text rangeOfString:@"."].location != NSNotFound || [textField.text isEqualToString:@""]) {
            return NO;
        } else {
            return YES;
        }
    } else {// 当前输入的不是'.'
        // 第一个字符是0时, 第二个不能再输入0
        if (textField.text.length == 1) {
            unichar str = [textField.text characterAtIndex:0];
            if (str == '0' && [string isEqualToString:@"0"]) {
                return NO;
            }
            if (str != '0' && str != '1') {// 1xx或0xx
                return YES;
            } else {
                if (str == '1') {
                    return YES;
                } else {
                    if ([string isEqualToString:@""]) {
                        return YES;
                    } else {
                        return NO;
                    }
                }
            }
        }
        
        // 已输入的字符串中包含'.'
        if ([textField.text rangeOfString:@"."].location != NSNotFound) {
            NSMutableString *str = [[NSMutableString alloc] initWithString:textField.text];
            [str insertString:string atIndex:range.location];
            if (str.length >= [str rangeOfString:@"."].location + 4) {
                return NO;
            }
            NSLog(@"str.length = %ld, str = %@, string.location = %ld", str.length, string, range.location);
        } else {
            if (textField.text.length > 5) {
                MyLog(@"da ye----%@",textField.text);
                return range.location < 11; //控制小数点之前是几位
            }
        }
    }
    MyLog(@"textField.text----%@",textField.text);
    NSString *str  = [NSString stringWithFormat:@"%@%@",textField.text,string];
    MyLog(@"str---%@",str);
    return YES;
}

#pragma mark - 输入不带小数且首位不能是0
- (BOOL)inputNumberWithoutDecimals:(UITextField *)textField
                 replacementString:(NSString *)string
     shouldChangeCharactersInRange:(NSRange)range {
    
    if([textField.text length] == 0) {
        if ([string length] > 0) {
            unichar finalStr = [string characterAtIndex:0];
            if (finalStr == '0') {
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
    }
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end
