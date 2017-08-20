//
//  ViewController.swift
//  YCEmoticonKeyboard
//
//  Created by daniel on 2017/8/20.
//  Copyright © 2017年 daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    fileprivate lazy var emoticonView: YCEmoticonView = YCEmoticonView(targetView: self.textView)
    fileprivate lazy var toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        
        // 3. 添加按钮
//        let itemSettings = [["imageName": "compose_toolbar_picture"],
//                            ["imageName": "compose_mentionbutton_background"],
//                            ["imageName": "compose_trendbutton_background"],
//                            ["imageName": "compose_emoticonbutton_background", "actionName": "selectEmoticon"],
//                            ["imageName": "compose_addbutton_background"]]

        let itemSettings = [["imageName": "compose_emoticonbutton_background", "actionName": "selectEmoticon"]]
        
        var items = [UIBarButtonItem]()
        
        for dict in itemSettings {
            
            items.append(UIBarButtonItem(image: UIImage(named: dict["imageName"]!), style: .plain, target: self, action: #selector(ViewController.toolItemClick(item:))))
            
            items.append(UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
        }
        items.removeLast()
        
        toolBar.items = items
        
        toolBar.tintColor = UIColor.lightGray
        
        return toolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        textView.inputView = emoticonView
        textView.alwaysBounceVertical = true
        textView.keyboardDismissMode = UIScrollViewKeyboardDismissMode.onDrag
        textView.delegate = self
        
        setupToolBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardChangeFrame(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
    }
    
    func setupToolBar() {
        
        view.addSubview(toolBar)
        
        toolBar.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
    }
    
    @objc func toolItemClick(item: UIBarButtonItem) {
        
        textView.resignFirstResponder()
        textView.inputView = textView.inputView == nil ? emoticonView : nil
        textView.becomeFirstResponder()
    }

}

extension ViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if textView.text.contains("输入一些文字...") {
            textView.text = text
        }
        
        return true
    }
    
    
}

extension ViewController {
    
    @objc fileprivate func keyboardChangeFrame(notification: NSNotification) {
        let endValue = notification.userInfo!["UIKeyboardFrameEndUserInfoKey"] as! NSValue
        let endFrame = endValue as! CGRect
        let duration = notification.userInfo!["UIKeyboardAnimationDurationUserInfoKey"] as! Double
        let screenH = UIScreen.main.bounds.height
        toolBar.snp.updateConstraints { (make) in
            make.bottom.equalToSuperview().offset(-(screenH - endFrame.origin.y))
        }
        
        UIView.animate(withDuration: duration) {
            UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
            self.view.layoutIfNeeded()
        }
    }
}

