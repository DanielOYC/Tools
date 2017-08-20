//
//  String+Emoji.swift
//  YCEmoticonKeyboard
//
//  Created by daniel on 2017/8/20.
//  Copyright © 2017年 daniel. All rights reserved.
//

import Foundation

extension String {
    
    /// 返回当前字符串中 16 进制对应 的 emoji 字符串
    var emoji: String {
        // 文本扫描器－扫描指定格式的字符串
        let scanner = Scanner(string: (self))
        
        // unicode 的值
        var value: UInt32 = 0
        scanner.scanHexInt32(&value)
        
        // 转换 unicode `字符`
        let chr = Character(UnicodeScalar(value)!)
        
        // 转换成字符串
        return "\(chr)"
    }
}
