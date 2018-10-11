//
//  TabView.swift
//  TabBar
//
//  Created by hsnm on 2018/10/10.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

protocol TabViewDelegate {
    /// タブ選択時にコール
    func didSelectTab(type: TabContentType)
}

final class TabView: UIStackView {
    
    var delegate: TabViewDelegate?
    
    var items: [TabContentType] = [] {
        didSet {
            items.forEach { type in
                let tabItemView = TabItemView.instantiate(with: type) { [weak self] type in
                    self?.delegate?.didSelectTab(type: type)
                }
                addArrangedSubview(tabItemView)
            }
        }
    }
    
    /// タブの選択状態を更新する
    ///
    ///   - type: TabContentType
    ///   - animated: Bool
    func select(_ type: TabContentType, animated: Bool) {
        arrangedSubviews.forEach { view in
            guard let tabItemView = view as? TabItemView else { return }
            tabItemView.configure(type, animated: animated)
        }
    }
}
