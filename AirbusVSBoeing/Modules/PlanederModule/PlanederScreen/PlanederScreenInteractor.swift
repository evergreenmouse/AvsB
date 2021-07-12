//
//  PlanderScreenInteractor.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit

final class PlanederScreenInteractor {
    weak var presenter: PlanederScreenInteractorOutput?
    
    private var database = [String: [Int]]()
    
    init() {
        resetCards()
    }

    private func resetCards() {
        database = [:]
        for model in Airplane.allCases {
            database[model.rawValue] = Array(0...9).shuffled()
        }
    }
    
}

extension PlanederScreenInteractor: PlanederScreenInteractorInput {
    func fetchCards(requiredNumber: Int) {
        var cardModels = [CardModel]()
        for _ in 0..<requiredNumber {
            guard let imageID = Airplane.allCases.randomElement(),
                  let indexesForChoose = database[imageID.rawValue],
                  !indexesForChoose.isEmpty else {
                return
            }
            print(imageID)
            guard let randomIndex = indexesForChoose.first else { return }
            let imageName = "\(imageID)_\(randomIndex)"
            database[imageID.rawValue]?.removeFirst()
            cardModels.append(CardModel(imageName: imageName, correctAnswer: imageID))
        }
            
        presenter?.interactor(self, didFetchModels: cardModels)
    }
}
