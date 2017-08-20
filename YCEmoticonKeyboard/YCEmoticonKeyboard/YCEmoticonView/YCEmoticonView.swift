//
//  YCEmoticonView.swift
//  YCEmoticonKeyboard
//
//  Created by daniel on 2017/8/20.
//  Copyright © 2017年 daniel. All rights reserved.
//

import UIKit
import SnapKit

fileprivate let kEmoticonCollectionViewCellId = "kEmoticonCollectionViewCellId"

class YCEmoticonView: UIView {
    
    fileprivate let kEmoticonToolBarH: CGFloat = 45.0              // 表情键盘底部工具条高度
    fileprivate let kEmoticonContentViewH: CGFloat = 226.0         // 表情键盘内容高度
    fileprivate lazy var packages: [YCEmoticons] = {    // 表情包数据源
        return YCEmoticonsViewModel().packages!
    }()
    
//    fileprivate var clickEmoticonCallBack: (YCEmoticon) -> ()
    
    weak var targetTextView: UITextView?
    
//    init(clickEmoticon: @escaping (YCEmoticon) -> ()) {
//        
//        clickEmoticonCallBack = clickEmoticon
//        
//        let tempFrame = CGRect(x: 0, y: 0, width: 0, height: kEmoticonToolBarH + kEmoticonContentViewH)
//        super.init(frame: tempFrame)
//        
//        setupUI()
//        
//        //准备历史表情数据
//        prepareHistoryEmoticons()
//
//    }
    
    init(targetView: UITextView) {
        
        targetTextView = targetView
//        targetTextView?.font = UIFont.systemFont(ofSize: 34)
        
        let tempFrame = CGRect(x: 0, y: 0, width: 0, height: kEmoticonToolBarH + kEmoticonContentViewH)
        super.init(frame: tempFrame)
        
        setupUI()
        
        //准备历史表情数据
        prepareHistoryEmoticons()
    }
    
    //准备历史表情数据
    fileprivate func prepareHistoryEmoticons() {
        
        let historyEmoticons = YCEmoticons(dic: ["emoticons" : ["" : ""]])
        packages.insert(historyEmoticons, at: 0)
    
    }
    
    @objc fileprivate func toolBarItemClick(item: UIBarButtonItem) {
        let index = item.tag - 1000
        
        emoticonContentView.scrollToItem(at: NSIndexPath(item: 0, section: index) as IndexPath, at: .left, animated: true)
    }
    
    // 底部工具条
    fileprivate lazy var toolBar: UIToolbar = UIToolbar()
    // 表情内容视图
    fileprivate lazy var emoticonContentViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 7
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        
        return layout
    }()
    fileprivate lazy var emoticonContentView: UICollectionView = {
        let contentView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.emoticonContentViewLayout)
        
        return contentView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - 设置界面
extension YCEmoticonView {
    
    fileprivate func setupUI() {
        
        addSubview(toolBar)
        addSubview(emoticonContentView)
        emoticonContentView.backgroundColor = UIColor.white
        
        toolBar.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(kEmoticonToolBarH)
        }
        
        emoticonContentView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(toolBar.snp.top)
        }
        
        // 设置工具条内容
        setupToolBar()
        // 设置表情内容视图
        setupEmoticonContentView()
    }
    
    // 设置工具条内容
    fileprivate func setupToolBar() {
        
        var items = [UIBarButtonItem]()
        
        let historyItem = UIBarButtonItem.init(title: "历史", style: .plain, target: self, action: #selector(YCEmoticonView.toolBarItemClick(item:)))
        historyItem.tag = 1000
        historyItem.tintColor = UIColor.darkGray
        items.append(historyItem)
        
        var index = 1
        for emoticons in packages {
            items.append(UIBarButtonItem.init(barButtonSystemItem: .flexibleSpace, target: nil, action: nil))
            let item = UIBarButtonItem.init(title: emoticons.group_name_cn, style: .plain, target: self, action: #selector(YCEmoticonView.toolBarItemClick(item:)))
            item.tag = 1000 + index
            item.tintColor = UIColor.darkGray
            items.append(item)
            index += 1
        }
        
        toolBar.items = items
    }
    
    // 设置表情内容视图
    fileprivate func setupEmoticonContentView() {
        
        let margin = (kEmoticonContentViewH - (UIScreen.main.bounds.width / 7 * 3)) / 2
        emoticonContentView.contentInset = UIEdgeInsetsMake(margin, 0, margin, 0)
        emoticonContentView.register(YCEmoticonViewCell.self, forCellWithReuseIdentifier: kEmoticonCollectionViewCellId)
        emoticonContentView.isPagingEnabled = true
        emoticonContentView.bounces = false
        emoticonContentView.dataSource = self
        emoticonContentView.delegate = self
        
    }
    
}


// MARK: - UICollectionView DataSource
extension YCEmoticonView: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return packages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return packages[section].emoticons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kEmoticonCollectionViewCellId, for: indexPath) as! YCEmoticonViewCell
        
        cell.emoticon = packages[indexPath.section].emoticons[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let emoticon = packages[indexPath.section].emoticons[indexPath.row]
        
        if emoticon.isDelete {
            targetTextView?.deleteBackward()
            return
        }
        
        if emoticon.code != nil {
            targetTextView?.replace(targetTextView!.selectedTextRange!, withText: emoticon.code!.emoji)
            return
        }
        
        if emoticon.pngPath != nil {
            
            let attachment = NSTextAttachment()
            attachment.image = UIImage(named: emoticon.pngPath!)
            let lineHeight = (targetTextView!.font?.lineHeight)! + 1.8
            attachment.bounds = CGRect.init(x: 0, y: -4, width: lineHeight, height: lineHeight)
            let imageAttributeString = NSMutableAttributedString(attributedString: NSAttributedString(attachment: attachment))
            imageAttributeString.addAttributes([NSFontAttributeName : targetTextView!.font!], range: NSRange.init(location: 0, length: 1))
            
            
            let attributeString = NSMutableAttributedString(attributedString: targetTextView!.attributedText)
            attributeString.replaceCharacters(in: targetTextView!.selectedRange, with: imageAttributeString)
            
            // 4. 替换属性文本
            // 1) 记录住`光标`位置
            let range = targetTextView!.selectedRange
            targetTextView!.attributedText = attributeString
            // 3) 恢复光标
            targetTextView!.selectedRange = NSRange(location: range.location + 1, length: 0)
            
            
            
            return
        }
    }
    
}


/// 表情Cell
fileprivate class YCEmoticonViewCell: UICollectionViewCell {
    
    var emoticon: YCEmoticon? {
        didSet {
            
            contentBtn.setTitle("", for: .normal)
            contentBtn.setImage(UIImage.init(named: ""), for: .normal)
            
            if emoticon!.isEmpty {
                contentBtn.setImage(UIImage.init(named: ""), for: .normal)
                return
            }
            
            if emoticon!.isDelete {
                contentBtn.setImage(UIImage.init(named: "compose_emotion_delete"), for: .normal)
                return
            }
            
            if emoticon!.pngPath != nil {
                contentBtn.setImage(UIImage.init(named: emoticon!.pngPath!), for: .normal)
                return
            }
            if emoticon!.emoji != nil {
                contentBtn.setTitle(emoticon?.emoji, for: .normal)
            }
            
        }
    }
    
    fileprivate lazy var contentBtn: UIButton = {
        let btn = UIButton()
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 32)
        btn.isUserInteractionEnabled = false
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(contentBtn)
        
        contentBtn.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
