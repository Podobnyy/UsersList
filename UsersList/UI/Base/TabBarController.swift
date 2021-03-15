//
//  TabBarController.swift
//  UsersList
//
//  Created by Сергей Александрович on 14.03.2021.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let items = self.tabBar.items else {
            return
        }
        let titles = ["Users", "Saved"]

        for x in 0..<items.count {
            items[x].title = titles[x]
        }
    }
    
    func showSaved() {
        self.selectedIndex = 1
    }
}
