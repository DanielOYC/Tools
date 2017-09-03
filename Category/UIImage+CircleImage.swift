//
//  UIImage+CircleImage.swift
//  TestAnimation
//
//  Created by daniel on 2017/9/3.
//  Copyright © 2017年 daniel. All rights reserved.
//

import UIKit

extension UIImage {
    
    //获得圆角图片
    class func circleImage(original: UIImage, clicpBounds: CGRect) -> UIImage {
        
        //开始绘图上下文
        UIGraphicsBeginImageContextWithOptions(clicpBounds.size, false, 0.0)
        //添加裁切路径
        let bounds = CGRect(x: 0, y: 0, width: clicpBounds.width, height: clicpBounds.height)
        let path = UIBezierPath(ovalIn: clicpBounds)
        path.addClip()
        //绘制图片
        original.draw(in: bounds)
        let tempImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return tempImage!
    }
    
    //获得带圆环的圆角图片
    class func circleImageWithRing(original: UIImage, clicpBounds: CGRect, ringWidth: CGFloat, ringColor: UIColor)  -> UIImage {
        
        //设置上下文尺寸
        let imageW = clicpBounds.width
        let contextW = imageW + 2 * ringWidth
        let contextSize = CGSize(width: contextW, height: contextW)
        
        //开始绘图上下文
        UIGraphicsBeginImageContextWithOptions(contextSize, false, 0.0)
        
        //绘制圆环
        let ringBounds = CGRect(x: 0, y: 0, width: contextW, height: contextW)
        let ringPath = UIBezierPath(ovalIn: ringBounds)
        ringColor.set()
        ringPath.fill()
        
        //添加裁切路径
        let imageBounds = CGRect(x: ringWidth, y: ringWidth, width: imageW, height: imageW)
        let path = UIBezierPath(ovalIn: imageBounds)
        path.addClip()
        //绘制图片
        original.draw(in: imageBounds)
        let tempImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tempImage!
    }
    
}

