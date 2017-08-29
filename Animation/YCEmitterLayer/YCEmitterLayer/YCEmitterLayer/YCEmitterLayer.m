//
//  YCEmitterLayer.m
//  YCEmitterLayer
//
//  Created by daniel on 2017/8/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "YCEmitterLayer.h"

@implementation YCEmitterLayer


/**
 类方法创建粒子layer
 
 @param center 发射起始点的中点
 @param size 发射器的大小
 @param images 例子显示的图片数组
 @return 返回layer
 */
+ (instancetype)layerWithCenter:(CGPoint)center size:(CGSize)size images:(NSArray *)images {
    
    YCEmitterLayer *layer = [self layer];
    
    // 发射器在xy平面的中心位置
    layer.emitterPosition = center;
    // 发射器的尺寸大小
    layer.emitterSize = size;
    
    // 渲染模式
    layer.renderMode = kCAEmitterLayerOldestLast;
//    layer.emitterShape = kCAEmitterLayerSphere;
    
    
    NSMutableArray *emitters = [NSMutableArray array];
    
    //创建粒子
    for (NSString *imageName in images) {
        // 发射单元
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        // 粒子的创建速率，默认为1/s
        cell.birthRate = 1;
        // 粒子存活时间
        cell.lifetime = arc4random_uniform(4) + 1;
        // 粒子的生存时间容差
        cell.lifetimeRange = 1.5;
        // 粒子显示的内容
        UIImage *image = [UIImage imageNamed:imageName];
        cell.contents = (__bridge id _Nullable)(image.CGImage);
        // 粒子的运动速度
        cell.velocity = arc4random_uniform(100) + 100;
        // 粒子速度的容差
        cell.velocityRange = 80;
        // 粒子在xy平面的发射角度
        cell.emissionLongitude = M_PI+M_PI_2;
        // 粒子发射角度的容差
        cell.emissionRange = M_PI_2/4;
        // 缩放比例
        cell.scale = 0.3;
        
        [emitters addObject:cell];
    }
    
    layer.emitterCells = emitters;
    
    return layer;
}

@end
