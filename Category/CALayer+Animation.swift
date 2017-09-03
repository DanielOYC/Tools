//
//  CALayer+Animation.swift
//  TestAnimation
//
//  Created by daniel on 2017/9/3.
//  Copyright © 2017年 daniel. All rights reserved.
//

import UIKit

extension CALayer {
    
    //暂停动画
    func pauseAnimation() {
        let pausedTime: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil)
        speed = 0.0
        timeOffset = pausedTime
    }
    
    //恢复动画
    func resumeAnimation() {
        let pausedTime: CFTimeInterval = timeOffset
        speed = 1.0
        beginTime = 0.0
        let timeSincePause: CFTimeInterval = convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        beginTime = timeSincePause
    }
    
}
