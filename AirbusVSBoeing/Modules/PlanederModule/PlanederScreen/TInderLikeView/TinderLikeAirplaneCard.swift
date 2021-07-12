//
//  TinderLikeAirplaneCard.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit

protocol TinderLikeAirplaneCardDelegate: AnyObject {
    func sendVariant(_ directionValue: CGFloat)
    func sendAnswer(_ isCorrect: Bool)
    func fetchMoreImages(requiredNumber: Int)
    func fallbackCard(card: TinderLikeAirplaneCard)
}

enum SwipeDirection {
    case left
    case right
}

final class TinderLikeAirplaneCard: UIView {
    
    private let theresoldMargin = UIScreen.main.bounds.size.width / 2 * 0.85
    private let stength : CGFloat = 4
    private let range : CGFloat = 0.90
    
    weak var delegate: TinderLikeAirplaneCardDelegate?
    
    private var model: CardModel?
    
    var xCenter: CGFloat = 0.0
    var yCenter: CGFloat = 0.0
    var originalPoint = CGPoint.zero

    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        return image
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizer()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.beingDragged))
        panGestureRecognizer.delegate = self
        addGestureRecognizer(panGestureRecognizer)
    }

    private func setupView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func configure(with model: CardModel, delegate: TinderLikeAirplaneCardDelegate) {
        self.delegate = delegate
        self.model = model
        guard let image = UIImage(named: model.imageName, in: Bundle(for: type(of: self)), compatibleWith: nil) else { return }
        imageView.image = image
    }

    @objc private func beingDragged(_ gestureRecognizer: UIPanGestureRecognizer) {
        xCenter = gestureRecognizer.translation(in: self).x
        yCenter = gestureRecognizer.translation(in: self).y
        
        switch gestureRecognizer.state {
        case .began:
            originalPoint = self.center
            break
        case .changed:
            let rotationStrength = min(xCenter / UIScreen.main.bounds.size.width, 1)
            let rotationAngel = .pi/8 * rotationStrength
            let scale = max(1 - abs(rotationStrength) / stength, range)
            center = CGPoint(x: originalPoint.x + xCenter, y: originalPoint.y + yCenter)
            let transforms = CGAffineTransform(rotationAngle: rotationAngel)
            let scaleTransform: CGAffineTransform = transforms.scaledBy(x: scale, y: scale)
            self.transform = scaleTransform
            delegate?.sendVariant(xCenter)
            break
        case .ended:
            afterSwipeAction()
        default:
            break
        }
    }

    private func handleSwipe(with direction: SwipeDirection) {
        // Arbus is left swipe and Boeing is right swipe
        var isAnswerCorrect = false
        guard let model = model else { return }
        switch direction {
        case .left:
            isAnswerCorrect = model.correctAnswer == .airbus
        case .right:
            isAnswerCorrect = model.correctAnswer == .boeing
        }
        delegate?.sendAnswer(isAnswerCorrect)
        let finishPoint = CGPoint(x: frame.size.width*2, y: 2 * yCenter + originalPoint.y)
        UIView.animate(withDuration: 0.5, animations: {
            self.center = finishPoint
        }, completion: { _ in
            self.removeFromSuperview()
        })
        delegate?.fetchMoreImages(requiredNumber: 1)
    }
    
    private func afterSwipeAction() {
        if xCenter > theresoldMargin {
            handleSwipe(with: .right)
            removeFromSuperview()
        }
        else if xCenter < -theresoldMargin {
            handleSwipe(with: .left)
            removeFromSuperview()
        }
        else {
            self.delegate?.fallbackCard(card: self)
            UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: [], animations: {
                self.center = self.originalPoint
                self.transform = CGAffineTransform(rotationAngle: 0)
            })
        }
    }
    
}

extension TinderLikeAirplaneCard: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

