//
//  UIColor+YCExtension.m
//  WaWa
//
//  Created by daniel on 2017/8/16.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "UIColor+YCExtension.h"

@implementation UIColor (YCExtension)

+ (instancetype)yc_colorWithHex:(u_int32_t)hex {
    
    u_int8_t red = (hex & 0xFF0000) >> 16;
    u_int8_t green = (hex & 0x00FF00) >> 8;
    u_int8_t blue = hex & 0x0000FF;
    
    return [UIColor yc_colorWithRed:red green:green blue:blue];
}

+ (instancetype)yc_colorWithRed:(u_int8_t)red green:(u_int8_t)green blue:(u_int8_t)blue {
    return [UIColor colorWithRed:(red) / 255.0 green:(green) / 255.0 blue:(blue) / 255.0 alpha:1.0];
}

+ (instancetype)yc_randomColor {
    u_int8_t red = arc4random_uniform(256);
    u_int8_t green = arc4random_uniform(256);
    u_int8_t blue = arc4random_uniform(256);
    
    return [UIColor yc_colorWithRed:red green:green blue:blue];
}

@end
