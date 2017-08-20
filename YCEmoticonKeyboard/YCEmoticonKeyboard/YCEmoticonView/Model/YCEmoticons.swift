//
//  YCEmoticons.swift
//  YCEmoticonKeyboard
//
//  Created by daniel on 2017/8/20.
//  Copyright © 2017年 daniel. All rights reserved.
//  某一种表情包模型

import UIKit

class YCEmoticons: NSObject {

    var id: String?                     //表情所在文件夹名
    var group_name_cn: String?          //组表情包名
    var emoticons: [YCEmoticon] = [YCEmoticon]()       //表情数组
    
    init(dic: [String : Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "emoticons" {
            
            if let arr = value as? NSArray {
                arr.enumerateObjects({ (obj, index, _) in
                    
                    let tempIndex = index + index / 21
                    
                    if (tempIndex + 1) % 21 == 0 {
                        let deleteEmoticon = YCEmoticon(dic: ["" : ""])
                        deleteEmoticon.isDelete = true
                        emoticons.append(deleteEmoticon)
                    }
                    
                    let emoticon = YCEmoticon(dic: obj as! [String : Any])
                    if emoticon.png != nil {
                        emoticon.pngPath = "Emoticons.bundle/" + id! + "/"
                    }else {
                        if let code = emoticon.code {
                            emoticon.emoji = code.emoji
                        }
                    }
                    emoticons.append(emoticon)
                    
                })
            }
            
            let emptyCout = 21 - emoticons.count % 21 - 1
            
            for _ in 0..<emptyCout {
                let emptyEmoticon = YCEmoticon(dic: ["" : ""])
                emptyEmoticon.isEmpty = true
                emoticons.append(emptyEmoticon)
            }
            
            let deleteEmoticon = YCEmoticon(dic: ["" : ""])
            deleteEmoticon.isDelete = true
            emoticons.append(deleteEmoticon)
            
            return
        }
        super.setValue(value, forKey: key)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
    override var description: String {
        let keys = ["id","group_name_cn"]
        
        return dictionaryWithValues(forKeys: keys).description
    }
}
