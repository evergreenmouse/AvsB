//
//  OnboardingView.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 12.07.2021.
//

import UIKit
import UserDataModule

final class OnboardingView: UIView {
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var swipeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var leftSwipeImageView: UIImageView = {
        let imageView = UIImageView()
        guard let image = UIImage(named: "left_swipe", in: Bundle(for: type(of: self)), compatibleWith: nil) else {
            return UIImageView()
        }
        imageView.contentMode = .scaleAspectFit
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var rightSwipeImageView: UIImageView = {
        let imageView = UIImageView()
        guard let image = UIImage(named: "right_swipe", in: Bundle(for: type(of: self)), compatibleWith: nil) else {
            return UIImageView()
        }
        imageView.contentMode = .scaleAspectFit
        imageView.image = image.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .white
        return imageView
    }()
    
    private lazy var leftSwipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Swipe left\nfor Airbus"
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rightSwipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Swipe right\nfor Boeing"
        label.numberOfLines = 2
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var gotItButton: UIButton = {
        let button = UIButton(type: .custom)
        button.addTarget(self, action: #selector(handleGotItButtonAction(_:)), for: .touchUpInside)
        button.setTitle("GOT IT!", for: .normal)
        button.titleLabel?.textColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .black.withAlphaComponent(0.7)
        swipeStackView.addArrangedSubview(leftSwipeImageView)
        swipeStackView.addArrangedSubview(rightSwipeImageView)
        
        labelsStackView.addArrangedSubview(leftSwipeLabel)
        labelsStackView.addArrangedSubview(rightSwipeLabel)
        
        addSubview(containerStackView)
        containerStackView.addArrangedSubview(swipeStackView)
        containerStackView.addArrangedSubview(labelsStackView)
        
        containerStackView.snp.makeConstraints { make in
            make.leading.trailing.centerY.equalToSuperview()
        }
        
        addSubview(gotItButton)
        gotItButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.top.equalTo(containerStackView.snp.bottom).offset(32)
            make.height.equalTo(44)
        }
    }

    @objc private func handleGotItButtonAction(_ sender: UIButton) {
        UserDataService.instance.onboardingWasShown = true
        removeFromSuperview()
    }
}
