//
//  YCAlertTool.m
//  YCAlertTool
//
//  Created by daniel on 2017/8/5.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "YCAlertTool.h"

@implementation YCAlertTool

/**
 封装系统UIAlertController(alert样式)
 
 @param title 标题
 @param message 信息
 @param object 从哪个对象弹出，传空或者传非controller对象，就从keyWindow的根控制器弹出
 @param callBack 点击按钮的回调，参数是所点击的按钮的标题
 @param cancelTitle 取消按钮标题，取消按钮是最底端按钮，且颜色与其他按钮不一样
 @param title1 其他按钮，可以传多个值，以nil结尾
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message presentedBy:(id)object  itemClickCallBack:(void (^)(NSString *))callBack cancelTitle:(NSString *)cancelTitle otherTitles:(NSString *)title1, ... {
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (title1) {     //如果有其他按钮就创建其他按钮
        
        [alertVC addAction:[UIAlertAction actionWithTitle:title1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (callBack) {
                callBack(title1);
            }
        }]];
        
        va_list params;      // 指向可变参数列表指针
        va_start(params, title1);       //使参数列表指针arg_ptr指向函数参数列表中的第一个可选参数
        id arg;
        while ((arg = va_arg(params, id))) {  //返回参数列表中指针arg_ptr所指的参数，返回类型为type，并使指针arg_ptr指向参数列表中下一个参数
            
            [alertVC addAction:[UIAlertAction actionWithTitle:arg style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (callBack) {
                    callBack(arg);
                }
            }]];
            
        }
        
        va_end(params);   //清空参数列表，并置参数指针arg_ptr无效
        
    }
    
    if (cancelTitle) {  //创建取消按钮
        
        [alertVC addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            if (callBack) {
                callBack(cancelTitle);
            }
        }]];
        
    }
    
    if ([object isKindOfClass:[UIViewController class]]) { //如果是控制器调用的
        
        UIViewController *vc = (UIViewController *)object;
        [vc presentViewController:alertVC animated:YES completion:nil];
        
    }else {    //不是控制器调用，是视图或者别的
        
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
        
    }
}

@end
