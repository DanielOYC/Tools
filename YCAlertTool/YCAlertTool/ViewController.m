//
//  ViewController.m
//  YCAlertTool
//
//  Created by daniel on 2017/8/5.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "ViewController.h"
#import "YCAlertTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [YCAlertTool showAlertWithTitle:@"提示" message:@"弹框测试" presentedBy:self itemClickCallBack:^(NSString *title) {
        NSLog(@"%@",title);
    } cancelTitle:@"取消" otherTitles:@"1",@"2",@"3",nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
