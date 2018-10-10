//
//  DViewController.swift
//  TabBar
//
//  Created by hsnm on 2018/10/09.
//  Copyright © 2018 hsnm. All rights reserved.
//

import UIKit

final class DViewController: ContentViewController {
    static func instantiateNavigationController() -> ContentNavigationController {
        let viewController = UIStoryboard(name: "DViewController", bundle: nil).instantiateInitialViewController() as! ContentNavigationController
        return viewController
    }
    
    var items: [Int] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "D"
        (0...100).forEach { items.append($0) }
        print(String(describing: self) + ": " +  #function)
    }
    
    override func selectCurrentTab() {
        if navigationController?.viewControllers.count == 1 {
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
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

extension DViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(items[indexPath.row])"
        return cell
    }
}

extension DViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detail = ListDetailViewController.instantiate()
        navigationController?.pushViewController(detail, animated: true)
    }
}

final class ListDetailViewController: UIViewController {
    static func instantiate() -> ListDetailViewController {
        let viewController = UIStoryboard(name: "DViewController", bundle: nil).instantiateViewController(withIdentifier: "ListDetailViewController") as! ListDetailViewController
        return viewController
    }
}
