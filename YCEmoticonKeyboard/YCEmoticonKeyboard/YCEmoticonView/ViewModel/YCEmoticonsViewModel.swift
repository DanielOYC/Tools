//
//  YCEmoticonsViewModel.swift
//  YCEmoticonKeyboard
//
//  Created by daniel on 2017/8/20.
//  Copyright © 2017年 daniel. All rights reserved.
//

import Foundation

class YCEmoticonsViewModel {
    
    var packages: [YCEmoticons]?
    
    init() {
        
        guard (packages?.count == nil || packages?.count == 0) else {
            return
        }
        
        let packagesPath = Bundle.main.path(forResource: "Emoticons.bundle/emoticons", ofType: "plist")
        let packagesDic = NSDictionary.init(contentsOfFile: packagesPath!)!
        packages = [YCEmoticons]()
        
        if let packagesArray = packagesDic["packages"] as? NSArray {
            packagesArray.enumerateObjects({ (obj, index, _) in
                
                if let dic = obj as? NSDictionary {
                    
                    let id = dic["id"] as! String
                    let emoticonsPath = Bundle.main.path(forResource: "Emoticons.bundle/\(id)/info", ofType: "plist")!
                    let emoticonsDic = NSDictionary.init(contentsOfFile: emoticonsPath)!
                    let emoticons = YCEmoticons(dic: emoticonsDic as! [String : Any])
                    packages?.append(emoticons)
                }
            })
        }
        
    }
}
