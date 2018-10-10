//
//  ContentViewController.swift
//  TabBar
//
//  Created by hsnm on 2018/10/10.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

protocol MainViewControllerChildTabDelegate {
    func moveToTab(at type: TabContentType)
}
extension MainViewControllerChildTabDelegate where Self: UIViewController {
    func moveToTab(at type: TabContentType) {}
}

class ContentViewController: UIViewController, MainViewControllerChildTabDelegate {
    var delegate: MainViewControllerChildTabDelegate?
    
    func clear() {
        delegate = nil
    }
}

class ContentNavigationController: UINavigationController {
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .white
    }
    
    func selectCurrentTab() {
        // Push遷移していたらトップ階層に戻る. トップ階層でスクロール可能なUIがあれば一番上に戻る等を行う
        popToRootViewController(animated: true)
    }
}
