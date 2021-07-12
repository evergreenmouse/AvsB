//
//  ABTabBarController.swift
//  AirbusVSBoeing
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit

final class ABTabBarController: UITabBarController {
    
    private var tabBarItems = [ABTabBarItem]()
    
    init(items: [ABTabBarItem]) {
        self.tabBarItems = items
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupTabs()
    }

    private func setupTabs() {
        var tabControllers = [UIViewController]()
        for (index, item) in tabBarItems.enumerated() {
            item.viewController.tabBarItem = UITabBarItem(title: item.title, image: item.image, tag: index)
            tabControllers.append(item.viewController)
        }
        viewControllers = tabControllers
    }
}
