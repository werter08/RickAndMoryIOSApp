//
//  RMCharacterInfoViewCell.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 30.03.2025.
//

import UIKit

final class RMCharacterInfoViewCellViewModel {
    
    private let type: `Type`
    private let value:String
    
    private var ShortDate:String {
        let isoF = ISO8601DateFormatter()
        isoF.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        
        if let date = isoF.date(from: value) {
            let dateF = DateFormatter()
            dateF.dateFormat = "dd.MM.yyyy"
            dateF.timeZone = TimeZone.current
            
            return dateF.string(from: date)
        }
        return "Years Ago"
    }
    
    public var toShowTitle:String{
        
        return type.GetToShowTitle
    }
    public var toShowValue:String{
    
        if value.isEmpty{
            return "None"
        }
        if type.GetToShowTitle == "CREATED"{
            return ShortDate
        }
        return value
    }
    public var toShowImage:UIImage?{
        
        return type.GetToShowImage
    }
    public var toShowColor:UIColor{
        
        return type.GetToShowColor
    }
    
    
    enum `Type`:String{
        case status
        case gender
        case type
        case species
        case origin
        case location
        case created
        case totalEpisodes
        
        var GetToShowTitle:String {
            switch self{
            case .status,.gender,.type,.species,.origin,.location,.created: return rawValue.uppercased()
            case .totalEpisodes: return "TOTAL EPISODES"
            }
        }
        var GetToShowImage:UIImage?{
            switch self{
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .species:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .totalEpisodes:
                return UIImage(systemName: "bell")
            }
        }
        var GetToShowColor:UIColor {
            switch self{
            case .status:
                return UIColor.systemRed
            case .gender:
                return UIColor.systemIndigo
            case .type:
                return UIColor.systemYellow
            case .species:
                return UIColor.systemGray
            case .origin:
                return UIColor.systemCyan
            case .location:
                return UIColor.systemMint
            case .created:
                return UIColor.systemPink
            case .totalEpisodes:
                return UIColor.systemGreen
            }
        }
        
        
        
    }
    
        
    
        init(type: `Type`, value:String){
            self.type = type
            self.value = value
        }
}
