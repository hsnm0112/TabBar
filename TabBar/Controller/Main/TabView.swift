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
                    // 各タブをタップした時の処理
                    guard let strongSelf = self else { return }
                    // 現在選択中のタブを再度選択した時は何もしない
                    guard strongSelf.currentTab != type else { return }
                    strongSelf.delegate?.didSelectTab(type: type)
                }
                // TODO: タブのソート対応時にitem更新には対応出来ていない
                addArrangedSubview(tabItemView)
            }
        }
    }
    
    /// タブの選択状態を更新する
    ///
    /// - Parameter type: TabContentType
    func select(with type: TabContentType) {
        currentTab = type
        arrangedSubviews.forEach { view in
            guard let tabItemView = view as? TabItemView else { return }
            // 種別を渡して各タブを活性 or 非活性状態に切り替える
            tabItemView.update(with: type)
        }
    }
}
