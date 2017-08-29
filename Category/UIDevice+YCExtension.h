//
//  UIDevice+YCExtension.h
//  Test
//
//  Created by daniel on 2017/8/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (YCExtension)

/**
 本机的设备描述

 @return 设备描述字符串，如iPhone 6
 */
+ (NSString*)deviceDescription;
@end
