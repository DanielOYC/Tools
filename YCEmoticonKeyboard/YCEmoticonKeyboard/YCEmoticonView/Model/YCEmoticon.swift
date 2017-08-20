//
//  YCEmoticon.swift
//  YCEmoticonKeyboard
//
//  Created by daniel on 2017/8/20.
//  Copyright © 2017年 daniel. All rights reserved.
//  单个表情模型

import UIKit

class YCEmoticon: NSObject {

    var chs: String?            //表情描述
    var png: String?            //表情图片名
    var code: String?           //emoji字符
    var emoji: String?
    var isEmpty: Bool = false
    var isDelete: Bool = false
    
    var pngPath: String? {
        didSet {
            pngPath = pngPath! + png!
        }
    }
    
    
    init(dic: [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["chs","png","code"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
