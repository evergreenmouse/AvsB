//
//  PlanederScreenPresenter.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit

final class PlanederScreenPresenter<Router: PlanederScreenRouterProtocol> {
    weak var view: PlanederScreenViewInput?
    
    var interactor: PlanederScreenInteractorInput?
    
    var router: Router?
}

extension PlanederScreenPresenter: PlanederScreenViewOutput {
    func fetchMoreImages(_ requiredNumber: Int) {
        interactor?.fetchCards(requiredNumber: requiredNumber)
    }
    
    func viewDidLoad(_ view: PlanederScreenViewInput) {
        interactor?.fetchCards(requiredNumber: 3)
    }
}

extension PlanederScreenPresenter: PlanederScreenInteractorOutput {
    func interactor(_ interactor: PlanederScreenInteractorInput, didFetchModels models: [CardModel]) {
        view?.applyModels(models)
    }
}
