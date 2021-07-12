//
//  TinderLikeView.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit

protocol TinderLikeViewDelegate: AnyObject {
    func fetchMoreImages(requiredNumber: Int)
    func fallbackCard(card: TinderLikeAirplaneCard)
    func sendVariant(with value: CGFloat)
    func sendAnswer(_ isCorrent: Bool)
}

final class TinderLikeView: UIView {
    
    weak var delegate: TinderLikeViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func add(_ models: [CardModel]) {
        if subviews.isEmpty {
            models.forEach {
                let card = createCardView(with: $0)
                addSubview(card)
                card.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(16)
                }
            }
        } else {
            models.forEach {
                let card = createCardView(with: $0)
                insertSubview(card, at: 0)
                card.snp.makeConstraints { make in
                    make.edges.equalToSuperview().inset(16)
                }
            }
        }
    }
}

private extension TinderLikeView {
    func createCardView(with model: CardModel) -> TinderLikeAirplaneCard {
        let card = TinderLikeAirplaneCard()
        card.configure(with: model, delegate: self)
        return card
    }
}

extension TinderLikeView: TinderLikeAirplaneCardDelegate {
    func sendVariant(_ directionValue: CGFloat) {
        delegate?.sendVariant(with: directionValue)
    }
    
    func sendAnswer(_ isCorrect: Bool) {
        delegate?.sendAnswer(isCorrect)
    }
    
    func fetchMoreImages(requiredNumber: Int) {
        delegate?.fetchMoreImages(requiredNumber: 1)
    }
    
    func fallbackCard(card: TinderLikeAirplaneCard) {
        delegate?.fallbackCard(card: card)
    }
}
