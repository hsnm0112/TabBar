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
    
    // タブバーのデリゲート
    var tabViewDelegate: TabViewDelegate?
    var childTabDelegate: MainViewControllerChildTabDelegate?
    
    // コンテンツ表示中のViewController
    var currentViewController: ContentViewController? {
        didSet {
            // 画面を切り替えるため、表示中のViewControllerを削除して次のViewControllerを表示する
            
            // セットされているViewControllerがあれば削除
            oldValue?.delegate = nil
            oldValue?.willMove(toParent: nil)
            oldValue?.view.removeFromSuperview()
            oldValue?.removeFromParent()
            
            // 画面のを切り替える
            currentViewController?.delegate = self
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
        currentViewController = viewControllers[type.rawValue] as? ContentViewController
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
