//
//  TabItemView.swift
//  TabBar
//
//  Created by hsnm on 2018/10/10.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

final class TabItemView: UIView {
    
    // MARK: Instantiate
    
    static func instantiate(with type: TabContentType, tapHandler: TapHandler? = nil) -> TabItemView {
        let tabItemView = UINib(nibName: "TabItemView", bundle: nil).instantiate(withOwner: self, options: nil)[0] as! TabItemView
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: tabItemView, action: #selector(TabItemView.tapped(_:)))
        tabItemView.addGestureRecognizer(tapGesture)
        tabItemView.tapHandler = tapHandler
        tabItemView.tabContentType = type
        tabItemView.textLabel.text = type.tabText
        tabItemView.textLabel.textColor = type.tintColor
        tabItemView.imageView.image = type.image
        tabItemView.imageView.tintColor = type.tintColor
        return tabItemView
    }
    
    // MARK: Handler
    
    typealias TapHandler = (TabContentType) -> Void
    var tapHandler: TapHandler?
    @objc func tapped(_ sender: UITapGestureRecognizer) {
        guard sender.state == .ended else { return }
        tapHandler?(tabContentType)
    }
    
    // MARK: Properties
    
    var tabContentType: TabContentType = .a
    
    // MARK: IBOutlet
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: Function
    
    func update(with type: TabContentType) {
        if tabContentType == type {
            // 選択状態にする
            textLabel.font = UIFont.boldSystemFont(ofSize: 12)
            textLabel.textColor = type.tintColor
            imageView.tintColor = type.tintColor
            imageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        } else {
            // 非選択状態にする
            textLabel.font = UIFont.systemFont(ofSize: 10)
            textLabel.textColor = .darkGray
            imageView.tintColor = .darkGray
            imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
}
