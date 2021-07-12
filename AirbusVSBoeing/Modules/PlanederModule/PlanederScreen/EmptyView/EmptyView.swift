//
//  EmptyView.swift
//  AirbusVSBoeing
//
//  Created by Ополовников Александр Николаевич on 12.07.2021.
//

import UIKit

final class EmptyView: UIView {
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Sorry, I've got no more images\nRepeating is on work now"
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(32)
            make.centerY.equalToSuperview().inset(128)
        }
    }
}


