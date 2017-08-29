//
//  YCEmitterLayer.h
//  YCEmitterLayer
//
//  Created by daniel on 2017/8/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface YCEmitterLayer : CAEmitterLayer

/**
 类方法创建粒子layer

 @param center 发射起始点的中点
 @param size 发射器的大小
 @param images 例子显示的图片数组
 @return 返回layer
 */
+ (instancetype)layerWithCenter:(CGPoint)center size:(CGSize)size images:(NSArray *)images;

@end
