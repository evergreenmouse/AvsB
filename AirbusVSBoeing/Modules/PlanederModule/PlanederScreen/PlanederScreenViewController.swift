//
//  PlanederViewController.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit
import UserDataModule

final class PlanederScreenViewController: UIViewController {
    
    var presenter: PlanederScreenViewOutput?
    
    private lazy var planederView: PlanederScreenView = {
        let view = PlanederScreenView()
        view.delegate = self
        return view
    }()
    
    override func loadView() {
        view = planederView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad(self)
        if !UserDataService.instance.onboardingWasShown {
            let onboardingView = OnboardingView()
            view.addSubview(onboardingView)
            onboardingView.snp.makeConstraints { $0.edges.equalToSuperview() }
        }
    }
}

extension PlanederScreenViewController: PlanederScreenViewInput {
    func applyModels(_ models: [CardModel]) {
        planederView.applyModels(models)
    }
    
}

extension PlanederScreenViewController: PlanederScreenViewDelegate {
    func fetchMoreImages(requiredNumber: Int, withReset: Bool) {
        presenter?.fetchMoreImages(requiredNumber)
    }
}
