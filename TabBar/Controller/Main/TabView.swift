//
//  TabView.swift
//  TabBar
//
//  Created by hsnm on 2018/10/10.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

protocol TabViewDelegate {
    func didSelectTab(type: TabContentType)
}

final class TabView: UIStackView {
    
    var delegate: TabViewDelegate?
    
    var currentTab: TabContentType = .a
    
    var items: [TabContentType] = [] {
        didSet {
            // StackViewに各タブを追加
            items.forEach { type in
                let tabItemView = TabItemView.instantiate(with: type) { [weak self] type in
                    self?.delegate?.didSelectTab(type: type)
                }
                // TODO: タブのソート対応時にitem更新には対応出来ていない
                addArrangedSubview(tabItemView)
            }
        }
    }
    
    /// タブの選択状態を更新する
    ///
    ///   - type: TabContentType
    ///   - animated: Bool
    func select(_ type: TabContentType, animated: Bool) {
        currentTab = type
        arrangedSubviews.forEach { view in
            guard let tabItemView = view as? TabItemView else { return }
            tabItemView.configure(type, animated: animated)
        }
    }
}
