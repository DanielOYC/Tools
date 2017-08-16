//
//  UIColor+YCExtension.h
//  WaWa
//
//  Created by daniel on 2017/8/16.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YCExtension)

/// 使用十六进制数字生成颜色
///
/// @param hex hex，格式 0xFFEEDD
///
/// @return UIColor
+ (nonnull instancetype)yc_colorWithHex:(u_int32_t)hex;

/// 使用指定的 r / g / b 数值生成颜色
///
/// @param red   red
/// @param green green
/// @param blue  blue
///
/// @return UIColor
+ (nonnull instancetype)yc_colorWithRed:(u_int8_t)red green:(u_int8_t)green blue:(u_int8_t)blue;

/// 生成随机颜色
///
/// @return UIColor
+ (nonnull instancetype)yc_randomColor;
@end
