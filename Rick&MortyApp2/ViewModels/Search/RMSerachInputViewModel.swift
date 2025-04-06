//
//  RMSerachViewModel.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 05.04.2025.
//

import UIKit

final class RMSearchInputViewModel {
    
    enum options: String {
        case locationType = "Location Type"
        case status = "Status"
        case gender = "Gender"
        
        var querys: String {
            switch self {
            case .locationType:
                return "type"
            case .status:
                return "status"
            case .gender:
                return "gender"
            }
        }
        
        var colors: UIColor {
            switch self {
            case .locationType:
                return UIColor.systemPink
            case .status:
                return UIColor.systemYellow
            case .gender:
                return UIColor.systemRed
            }
        }
        
        var sections: [String] {
            switch self {
            case .locationType:
                return ["Planet", "Space station","Microverce"]
            case .status:
                return ["alive", "dead", "unknown"]
            case .gender:
                return ["female", "male", "genderless", "unknown"]
            }
        }
    }
    
    private let type: RMSearchViewController.Config.`Type`
    
    init(type: RMSearchViewController.Config.`Type`) {
        self.type = type
    }
    
    //MARK: - Public
    var hasOptionButtons: Bool {
        switch type {
        case .location, .character:
            return true
        case .episode:
            return false
        }
    }
    var optionButtonTitles: [options] {
        switch type {
        case .location:
            return [.locationType]
        case .episode:
            return []
        case .character:
            return [.gender, .status]
        }
    }
    
    
    
    var searchPlaceHolder: String {
        switch type {
        case .location:
            return "Location Name"
        case .episode:
            return "Episode Title"
        case .character:
            return "Character Name"
        }
    }
}
