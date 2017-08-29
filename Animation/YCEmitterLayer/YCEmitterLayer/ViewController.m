//
//  ViewController.m
//  YCEmitterLayer
//
//  Created by daniel on 2017/8/29.
//  Copyright © 2017年 Daniel. All rights reserved.
//

#import "ViewController.h"
#import "YCEmitterLayer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;
    
    CGPoint center = CGPointMake(screenW * 0.5, screenH);
    CGSize size = CGSizeMake(80, 80);
    
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i < 10; i++) {
        NSString *imageStr = [NSString stringWithFormat:@"good%d_30x30",i];
        [images addObject:imageStr];
    }
    YCEmitterLayer *layer = [YCEmitterLayer layerWithCenter:center size:size images:images];
    [self.view.layer addSublayer:layer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
