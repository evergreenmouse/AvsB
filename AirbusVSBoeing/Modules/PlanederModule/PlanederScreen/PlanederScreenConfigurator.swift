//
//  PlanederConfigurator.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit

final public class PlanederScreenConfigurator {
    
    public init() { }
    
    public func getViewController() -> UIViewController {
        let viewController = PlanederScreenViewController()
        let presenter = PlanederScreenPresenter<PlanederScreenRouter>()
        let interactor = PlanederScreenInteractor()
        let router = PlanederScreenRouter()
        
        router.viewController = viewController
        presenter.router = router

        interactor.presenter = presenter
        presenter.interactor = interactor

        viewController.presenter = presenter
        presenter.view = viewController
        return viewController
    }
    
}
