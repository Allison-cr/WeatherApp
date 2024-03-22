//
//  SettingsViewViewModel.swift
//  WeatherApp
//
//  Created by Alexander Suprun on 21.03.2024.
//

import Foundation

struct SettingsViewViewModel {
    let option: [SettingOption]
}

enum SettingOption: CaseIterable {
    case upgrade
    case privacyPolicy
    case terms
    case contact
    case getHelp
    case rateApp
    
    var title: String {
        switch self {
        case .upgrade:
            return "Upgrade Plan"
        case .privacyPolicy:
            return "Privacy Policy"
        case .terms:
            return "Terms of use"
        case .contact:
            return "Contact us"
        case .getHelp:
            return "Get Help"
        case .rateApp:
            return "Rate App!"
        }
    }
}
