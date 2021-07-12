//
//  PlanederScreenModels.swift
//  PlanederModule
//
//  Created by Ополовников Александр Николаевич on 11.07.2021.
//

import UIKit

enum Airplane: String, CaseIterable {
    case boeing
    case airbus
}

struct CardModel {
    let imageName: String
    let correctAnswer: Airplane
}
