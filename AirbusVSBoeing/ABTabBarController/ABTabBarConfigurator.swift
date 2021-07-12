//
//  ABTabBarConfigurator.swift
//  AirbusVSBoeing
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit
import PlanederModule
import DetectorModule
import ClassificationModule

final class ABTabBarConfigurator {
    
    init() { }
    
    func configureTabBarController() -> UITabBarController {
        var tabBarItems = [ABTabBarItem]()
        let planederTabBarItem = ABTabBarItem(viewController: PlanederScreenConfigurator().getViewController(), title: "Let's play", image: UIImage())
        let objectDetectionTabBarItem = ABTabBarItem(viewController: VisionObjectDetectionViewController(), title: "Detection", image: UIImage())
        let imageClassificationTabBarItem = ABTabBarItem(viewController: ImageClassificationViewController(), title: "Classification", image: UIImage())
        tabBarItems.append(imageClassificationTabBarItem)
        tabBarItems.append(planederTabBarItem)
        tabBarItems.append(objectDetectionTabBarItem)
        let tabBarController = ABTabBarController(items: tabBarItems)
        tabBarController.selectedIndex = 1
        return tabBarController
    }
}
