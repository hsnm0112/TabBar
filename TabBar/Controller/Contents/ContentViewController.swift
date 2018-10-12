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
    
    func selectCurrentTab() {
        // Push遷移していたらトップ階層に戻る. トップ階層でスクロール可能なUIがあれば一番上に戻る等を行う
        navigationController?.popToRootViewController(animated: true)
    }
}

class ContentNavigationController: UINavigationController {
    func remove() {
        willMove(toParentViewController: nil)
        view.removeFromSuperview()
        removeFromParentViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .white
    }
    
    func selectCurrentTab() {
        guard viewControllers.count == 1 else {
            popToRootViewController(animated: true)
            return
        }
        if let top = topViewController as? ContentViewController {
           top.selectCurrentTab()
        }
    }
}
