//
//  PlanederScreenView.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit
import SnapKit

protocol PlanederScreenViewDelegate: AnyObject {
    func fetchMoreImages(requiredNumber: Int, withReset: Bool)
}

final class PlanederScreenView: UIView {
    
    weak var delegate: PlanederScreenViewDelegate?
    
    private var correctAnswersCount: Int = 0 {
        didSet {
            resultLabel.text = "Total count: \(correctAnswersCount)"
        }
    }

    private lazy var backgoroundImageView: UIImageView = {
        let imageView = UIImageView()
        guard let image = UIImage(named: "sky", in: Bundle(for: type(of: self)), compatibleWith: nil) else {
            return UIImageView()
        }
        imageView.image = image
        return imageView
    }()

    private lazy var emptyView: EmptyView = {
        let view = EmptyView()
        return view
    }()
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.text = "Your choice is:"
        label.numberOfLines = 0
        return label
    }()

    private lazy var variantLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 33, weight: .bold)
        label.text = "Boeing"
        label.numberOfLines = 0
        label.alpha = 0.01
        return label
    }()

    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.backgroundColor = .systemBlue.withAlphaComponent(0.2)
        label.textColor = .white
        label.font = .systemFont(ofSize: 33, weight: .bold)
        label.text = "Total count: 0"
        return label
    }()

    private lazy var tinderLikeView: TinderLikeView = {
        let view = TinderLikeView()
        view.delegate = self
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutSubviews()

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(backgoroundImageView)
        addSubview(emptyView)
        addSubview(tinderLikeView)
        addSubview(title)
        addSubview(variantLabel)
        addSubview(resultLabel)
        backgoroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        emptyView.snp.makeConstraints { $0.edges.equalToSuperview() }
        
        title.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(32)
        }
        tinderLikeView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(snp.width)
        }
        variantLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(title.snp.bottom).offset(8)
            make.height.equalTo(80)
            make.bottom.equalTo(tinderLikeView.snp.top).inset(32)
        }
        resultLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(tinderLikeView.snp.bottom).offset(16)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func applyModels(_ models: [CardModel]) {
        tinderLikeView.add(models)
    }
}

extension PlanederScreenView: TinderLikeViewDelegate {
    func sendAnswer(_ isCorrent: Bool) {
        if isCorrent {
            correctAnswersCount += 1
        }
        dropVariantLabel()
    }
    
    func sendVariant(with value: CGFloat) {
        variantLabel.text = value > 0 ? Airplane.boeing.rawValue : Airplane.airbus.rawValue
        variantLabel.alpha = abs(value) / UIScreen.main.bounds.size.width * 2
        
    }
    
    func fetchMoreImages(requiredNumber: Int) {
        delegate?.fetchMoreImages(requiredNumber: requiredNumber, withReset: false)
    }
    
    func fallbackCard(card: TinderLikeAirplaneCard) {
        dropVariantLabel()
    }
    
    func dropVariantLabel() {
        variantLabel.text = " "
        variantLabel.alpha = 0
    }
    
}
