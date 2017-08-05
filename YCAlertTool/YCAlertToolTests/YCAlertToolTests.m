//
//  YCAlertToolTests.m
//  YCAlertToolTests
//
//  Created by daniel on 2017/8/5.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "YCAlertTool.h"

@interface YCAlertToolTests : XCTestCase

@end

@implementation YCAlertToolTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    
    [YCAlertTool showAlertWithTitle:@"" message:@"" presentedBy:nil itemClickCallBack:^(NSString *title) {
        NSLog(@"%@",title);
    } cancelTitle:@"取消" otherTitles:@"1",@"2",@"3",nil];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
