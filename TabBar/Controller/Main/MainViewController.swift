//
//  MainViewController.swift
//  TabBar
//
//  Created by hsnm on 2018/10/09.
//  Copyright © 2018 hsnm. All rights reserved.
//

import Foundation
import UIKit

final class MainNavigationController: UINavigationController {
    
    // MARK: Instantiate
    static func instantiate() -> MainNavigationController {
        let mainViewController = MainViewController.instantiate()
        let mainNavigationController = MainNavigationController(rootViewController: mainViewController)
        return mainNavigationController
    }
}

final class MainViewController: UIViewController, TabViewDelegate {
    
    // MARK: Instantiate
    static func instantiate() -> MainViewController {
        let viewController = UIStoryboard(name: "MainViewController", bundle: nil).instantiateInitialViewController() as! MainViewController
        return viewController
    }
    
    // MARK: IBOutlet
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tabView: TabView!
    
    // MARK: Properties
    
    // タブバーのデリゲート
    var tabViewDelegate: TabViewDelegate?
    
    // 表示するViewController
    var currentViewController: UIViewController? {
        didSet {
            // セットされているViewControllerがあれば削除
            oldValue?.willMove(toParent: nil)
            oldValue?.view.removeFromSuperview()
            oldValue?.removeFromParent()
            
            // 画面のを切り替える
            guard let contentViewController = currentViewController else { return }
            addChild(contentViewController)
            contentViewController.didMove(toParent: self)
            guard isViewLoaded else { return }
            contentViewController.view.frame = containerView.bounds
            containerView.addSubview(contentViewController.view)
        }
    }
    
    var viewControllers: [UIViewController] = [
        AViewController.instantiate(),
        BViewController.instantiate(),
        CViewController.instantiate(),
        DViewController.instantiate()
    ]
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "ヘッダー画像"
        tabView.delegate = self
        
        // タブアイテムを配置
        tabView.items = [.a, .b, .c, .d]
        
        // 指定のメイン画面を表示
        switchContent(with: .b)
    }
    
    // MARK: Private Function
    
    // タブ選択状態の切り替え & 画面の切り替え
    private func switchContent(with type: TabContentType) {
        tabView.select(with: type)
        currentViewController = viewControllers[type.rawValue]
    }
    
    // MARK: TabBarDelegate
    
    /// タブ選択時にコール
    ///
    /// - Parameter type: TabContentType
    func didSelectTab(type: TabContentType) {
        switchContent(with: type)
    }
}

enum TabContentType: Int {
    case a = 0
    case b = 1
    case c = 2
    case d = 3
    
    // MARK: Properties
    
    // サンプルなので適当
    var image: UIImage? {
        return UIImage(named: "home")?.withRenderingMode(.alwaysTemplate)
    }
    
    // タブに表示するテキスト
    var tabText: String {
        switch self {
        case .a:
            return "aaa"
        case .b:
            return "bbb"
        case .c:
            return "ccc"
        case .d:
            return "ddd"
        }
    }
    
    var tintColor: UIColor {
        switch self {
        case .a:
            return .blue
        case .b:
            return .brown
        case .c:
            return .cyan
        case .d:
            return .green
        }
    }
}

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
