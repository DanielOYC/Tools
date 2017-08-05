//
//  YCAlertTool.h
//  YCAlertTool
//
//  Created by daniel on 2017/8/5.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YCAlertTool : NSObject

/**
 封装系统UIAlertController(alert样式)

 @param title 标题
 @param message 信息
 @param object 从哪个对象弹出，传空或者传非controller对象，就从keyWindow的根控制器弹出
 @param callBack 点击按钮的回调，参数是所点击的按钮的标题
 @param cancelTitle 取消按钮标题，取消按钮是最底端按钮，且颜色与其他按钮不一样
 @param title1 其他按钮，可以传多个值，以nil结尾
 */
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message presentedBy:(id)object itemClickCallBack:(void (^)(NSString *title))callBack cancelTitle:(NSString *)cancelTitle otherTitles:(NSString *)title1,...;

@end
