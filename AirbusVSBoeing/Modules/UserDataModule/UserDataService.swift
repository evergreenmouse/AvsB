//
//  UserDataService.swift
//  Airbus vs Boeing
//
//  Created by Ополовников Александр Николаевич on 12.07.2021.
//

import Foundation

fileprivate enum UserDataServiceKeys: String {
    case onboardingWasShown
}

public final class UserDataService {
    static public let instance = UserDataService()
    
    public var onboardingWasShown: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDataServiceKeys.onboardingWasShown.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDataServiceKeys.onboardingWasShown.rawValue)
        }
    }
}
