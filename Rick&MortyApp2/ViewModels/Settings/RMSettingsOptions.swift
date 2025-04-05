//
//  RMSettingsViewViewModul.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 04.04.2025.
//
import UIKit

enum RMSettingsOptions: CaseIterable {
    
    case rateApp
    case contactUs
    case terms
    case privacy
    case apireference
    case viewCode
    
    var titleLabel: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms"
        case .privacy:
            return "Privacy"
        case .apireference:
            return "API Reference"
        case .viewCode:
            return "View Code"
        }
    }
    
    var titleIcon: UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane")
        case .terms:
            return UIImage(systemName: "doc")
        case .privacy:
            return UIImage(systemName: "lock")
        case .apireference:
            return UIImage(systemName: "list.clipboard")
        case .viewCode:
            return UIImage(systemName: "hammer.fill")
        }
    }
    
    var iconFrameColor: UIColor {
        switch self {
        case .rateApp:
            return .systemRed
        case .contactUs:
            return .systemBlue
        case .terms:
            return .systemPink
        case .privacy:
            return .systemOrange
        case .apireference:
            return .systemTeal
        case .viewCode:
            return .systemGreen
        }
    }
    var link: URL? {
        switch self {
        case .rateApp:
            nil
        case .contactUs:
            URL(string: "https://rickandmortyapi.com/support-us")
        case .terms:
            URL(string: "https://rickandmortyapi.com/about")
        case .privacy:
            URL(string: "https://rickandmortyapi.com/support-us")
        case .apireference:
            URL(string: "https://rickandmortyapi.com/documentation")
        case .viewCode:
            URL(string: "https://github.com/werter08/RickAndMoryIOSApp")
        }
    }
}
