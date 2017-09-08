//
//  UINavigationController+Extension.m
//  TestHeaderView
//
//  Created by daniel on 2017/9/8.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "UINavigationController+Extension.h"
#import <objc/runtime.h>

@interface YCFullScreenBackDelegate : NSObject <UIGestureRecognizerDelegate>
@property (nonatomic,weak) UINavigationController *navigationController;
@end

@implementation YCFullScreenBackDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return YES;
}

@end

@implementation UINavigationController (Extension)

/**
 Invoked whenever a class or category is added to the Objective-C runtime
 */
+ (void)load {
    [super load];
    
    // hook 系统导航栏的pushViewController方法,使用自己的方法
    Method originalMethod = class_getInstanceMethod(self, @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod(self, @selector(yc_pushViewController:animated:));
    
    method_exchangeImplementations(originalMethod, swizzledMethod);
}


- (void)yc_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 判断要push进去的控制的view是否添加了pan手势
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:[self yc_panGestureRecognizer]]) {
        
        //添加pan手势
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:[self yc_panGestureRecognizer]];
        
        //获取系统的实现滑动返回的对象与方法
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id target = [targets.firstObject valueForKey:@"target"];
        SEL sel = NSSelectorFromString(@"handleNavigationTransition:");
        //把系统实现滑动返回的对象与方法添加到自己实现的pan手势上
        [[self yc_panGestureRecognizer] addTarget:target action:sel];
        [self yc_panGestureRecognizer].delegate = [self yc_fullScreenBackDelegate];
        
        //禁止系统手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    
    if (![self.viewControllers containsObject:viewController]) {
        [self yc_pushViewController:viewController animated:animated];
    }
}

- (YCFullScreenBackDelegate *)yc_fullScreenBackDelegate {
    
    YCFullScreenBackDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    
    if (delegate == nil) {
        delegate = [[YCFullScreenBackDelegate alloc] init];
        delegate.navigationController = self;
        
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return delegate;
}


- (UIPanGestureRecognizer *)yc_panGestureRecognizer {
    
    UIPanGestureRecognizer *pan = objc_getAssociatedObject(self, _cmd);
    
    if (pan == nil) {
        pan = [[UIPanGestureRecognizer alloc] init];
        pan.maximumNumberOfTouches = 1;
        objc_setAssociatedObject(self, _cmd, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return pan;
}

@end
