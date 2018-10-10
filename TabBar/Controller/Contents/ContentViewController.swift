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
}
