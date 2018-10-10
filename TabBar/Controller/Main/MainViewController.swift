//
//  MainViewController.swift
//  TabBar
//
//  Created by hsnm on 2018/10/09.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: Instantiate
    static func instantiate() -> MainViewController {
        let viewController = UIStoryboard(name: "MainViewController", bundle: nil).instantiateInitialViewController() as! MainViewController
        return viewController
    }
    
    // MARK: IBOutlet
    
    /// タブごとのコンテンツを表示
    @IBOutlet weak var containerView: UIView!
    /// 下タブ
    @IBOutlet weak var tabView: TabView!
    
    // MARK: Properties
    
    /// タブバーのデリゲート
    var tabViewDelegate: TabViewDelegate?
    /// コンテンツ内からのデリゲート
    var childTabDelegate: MainViewControllerChildTabDelegate?
    
    // コンテンツ表示中のViewController
    var currentNavigationViewController: ContentNavigationController? {
        didSet {
            if let vc = oldValue?.topViewController as? ContentViewController {
                vc.clear()
            }
            oldValue?.remove()
            
            // 画面のを切り替える
            guard let currentNavigationViewController = currentNavigationViewController else { return }
            addChild(currentNavigationViewController)
            currentNavigationViewController.didMove(toParent: self)
            if let vc = currentNavigationViewController.topViewController as? ContentViewController {
                vc.delegate = self
            }
            currentNavigationViewController.view.frame = containerView.bounds
            containerView.addSubview(currentNavigationViewController.view)
        }
    }
    
    var viewControllers: [ContentNavigationController] = [
        AViewController.instantiateNavigationController(),
        BViewController.instantiateNavigationController(),
        CViewController.instantiateNavigationController(),
        DViewController.instantiateNavigationController()
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
    
    /// 表示コンテンツ切り替え
    ///
    /// - Parameter type: TabContentType
    /// - Note: 選択したタブが表示中のものであればタブの階層トップに戻る
    private func switchContent(with type: TabContentType) {
        tabView.select(with: type)
        
        if let current = currentNavigationViewController, current.isEqual(viewControllers[type.rawValue]) {
            currentNavigationViewController?.selectCurrentTab()
        } else {
            currentNavigationViewController = viewControllers[type.rawValue]
        }
    }
}

extension MainViewController: TabViewDelegate {
    /// タブ選択時にコール
    ///
    /// - Parameter type: TabContentType
    func didSelectTab(type: TabContentType) {
        switchContent(with: type)
    }
}

extension MainViewController: MainViewControllerChildTabDelegate {
    func moveToTab(at type: TabContentType) {
        switchContent(with: type)
    }
}
