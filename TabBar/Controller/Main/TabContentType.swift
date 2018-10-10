//
//  TabContentType.swift
//  TabBar
//
//  Created by hsnm on 2018/10/10.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

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
