//
//  PlannderScreenContract.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import Foundation

protocol PlanederScreenViewOutput: AnyObject {
    func viewDidLoad(_ view: PlanederScreenViewInput)
    func fetchMoreImages(_ requiredNumber: Int)
}

protocol PlanederScreenViewInput: AnyObject {
    func applyModels(_ models: [CardModel])
}

protocol PlanederScreenInteractorOutput: AnyObject {
    func interactor(_ interactor: PlanederScreenInteractorInput, didFetchModels models: [CardModel])
}

protocol PlanederScreenInteractorInput: AnyObject {
    func fetchCards(requiredNumber: Int)
}

protocol PlanederScreenRouterProtocol: AnyObject { }

protocol PlanederScreenCollectionManagerDelegate: AnyObject { }
