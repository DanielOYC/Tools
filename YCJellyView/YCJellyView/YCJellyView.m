//
//  YCJellyView.m
//  YCJellyView
//
//  Created by daniel on 2017/8/4.
//  Copyright © 2017年 daniel. All rights reserved.
//

#import "YCJellyView.h"

#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
#define kMinHeight 0
#define kControlViewW 1
#define kControlViewH 1
#define kControlViewColor [UIColor clearColor]
#define kDefaultControlX (kScreenW / 2.0)
#define kDefaultControlY kMinHeight
#define kScale 0.7

@interface YCJellyView ()
{
    CGFloat _controlX;
    CGFloat _controlY;
    CAShapeLayer *_shapeLayer;
    UIView *_controlView;
    CADisplayLink *_displayLink;
    BOOL _isInAnimation;
}

@end

@implementation YCJellyView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        //添加涂层
        _shapeLayer = [[CAShapeLayer alloc] init];
        _shapeLayer.fillColor = [UIColor greenColor].CGColor;
        [self.layer addSublayer:_shapeLayer];
        
        //初始化控制点坐标
        _controlX = kDefaultControlX;
        _controlY = kDefaultControlY;
        
        //添加控制点视图
        _controlView = [[UIView alloc] initWithFrame:CGRectMake(_controlX, _controlY, kControlViewW, kControlViewH)];
        _controlView.backgroundColor = kControlViewColor;
        [self addSubview:_controlView];
        
        //添加手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanAction:)];
        [self addGestureRecognizer:pan];
        
        //添加定时器,CADisplayLink一秒钟刷新60次，做动画一般使用CADisplayLink而不是NSTimer
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(caculateControlPoint)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        _displayLink.paused = YES;                   //默认暂停定时器
        
        _isInAnimation = NO;
    }
    
    //更新图层路径
    [self updateShapeLayerPath];
    
    return self;
    
}

#pragma mark - 更新图层路径
- (void)updateShapeLayerPath {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0, 0)];                              //dot1
    [path addLineToPoint:CGPointMake(kScreenW, 0)];                    //dot2
    [path addLineToPoint:CGPointMake(kScreenW, kMinHeight)];           //dot3
    [path addQuadCurveToPoint:CGPointMake(0, kMinHeight)               //dot4
                 controlPoint:CGPointMake(_controlX, _controlY)];      //控制点
    [path closePath];
    _shapeLayer.path = path.CGPath;
    
}

#pragma mark - 处理手势拖动
- (void)handlePanAction:(UIPanGestureRecognizer *)pan {
    
    if (!_isInAnimation) {
    
        if (pan.state == UIGestureRecognizerStateChanged) {
            
            CGPoint translationP = [pan translationInView:self];           //拖动时触摸点位置
            
            CGFloat currentY = kDefaultControlY + translationP.y * kScale;
            _controlY = currentY < kMinHeight ? kMinHeight : currentY;     //改变控制点位置
            _controlY = currentY >= kScreenH ? kScreenH : _controlY;
            _controlX = kDefaultControlX + translationP.x;
            
            _controlView.frame = CGRectMake(_controlX, _controlY, kControlViewW, kControlViewH);
            
            [self updateShapeLayerPath];                                   //计算完更新路径
            
        }else if(pan.state == UIGestureRecognizerStateEnded ||
                 pan.state == UIGestureRecognizerStateFailed ||
                 pan.state == UIGestureRecognizerStateCancelled ){
            
            _displayLink.paused = NO;
            _isInAnimation = YES;
            
            [UIView animateWithDuration:1.0
                                  delay:0
                 usingSpringWithDamping:0.5
                  initialSpringVelocity:0.0
                                options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 
                                 _controlView.frame = CGRectMake(kDefaultControlX, kDefaultControlY, kControlViewW, kControlViewH);
                                 
                             } completion:^(BOOL finished) {
                                 if (finished) {
                                     _displayLink.paused = YES;
                                     _isInAnimation = NO;
                                 }
                             }
             ];
        }

    }
    
}

#pragma mark - 开启定时器计算当前控制点的位置
- (void)caculateControlPoint {
    
    CALayer *layer = _controlView.layer.presentationLayer;
    _controlX = layer.position.x;
    _controlY = layer.position.y;
    [self updateShapeLayerPath];
}

@end
