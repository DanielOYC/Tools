//
//  ViewController.m
//  YCJellyView
//
//  Created by daniel on 2017/8/4.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "ViewController.h"
#import "YCJellyView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YCJellyView *jellyView = [[YCJellyView alloc] initWithFrame:self.view.bounds];
    jellyView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:jellyView];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"试试向下拖动";
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
