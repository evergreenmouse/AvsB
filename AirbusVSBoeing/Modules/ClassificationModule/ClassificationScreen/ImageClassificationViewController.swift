//
//  ImageClassificationScreen.swift
//  ClassificationModule
//
//  Created by Ополовников Александр Николаевич on 12.07.2021.
//

import UIKit
import  SnapKit

final public class ImageClassificationViewController: UIViewController {

    private lazy var comingSoonLabel: UILabel = {
        let label = UILabel()
        label.text = "Image classification\nis coming soon..."
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 2
        return label
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(comingSoonLabel)
        comingSoonLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
    }
}
