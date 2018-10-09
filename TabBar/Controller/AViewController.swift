//
//  AViewController.swift
//  TabBar
//
//  Created by hsnm on 2018/10/09.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

final class AViewController: UIViewController {
    static func instantiate() -> AViewController {
        let viewController = UIStoryboard(name: "AViewController", bundle: nil).instantiateInitialViewController() as! AViewController
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(String(describing: self) + ": " +  #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(String(describing: self) + ": " +  #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(String(describing: self) + ": " +  #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(String(describing: self) + ": " +  #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(String(describing: self) + ": " +  #function)
    }
}
