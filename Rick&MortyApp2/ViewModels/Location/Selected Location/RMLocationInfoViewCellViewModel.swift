//
//  RMCharacterInfoViewCell.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 30.03.2025.
//

import UIKit

final class RMLocationInfoViewCellViewModel {
    
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
    public var toShowColor:UIColor{
        
        return type.GetToShowColor
    }
    
    public var toShowIcon:UIImage?{
        
        return type.GetToShowImage
    }
    
    enum `Type`:String{
        case created
        case name
        case type
        case dimension
        
        var GetToShowTitle:String {
            switch self{
            case .created,.name,.type: return rawValue.uppercased()
            case .dimension: return "TOTAL CHARACTERS"
            }
        }
        var GetToShowImage:UIImage?{
            switch self{
            case .created:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .name:
                return UIImage(systemName: "bell")
            case .dimension:
                return UIImage(systemName: "bell")
            }
        }
        var GetToShowColor:UIColor {
            switch self{
            case .created:
                return UIColor.systemRed
            case .type:
                return UIColor.systemMint
            case .name:
                return UIColor.systemPink
            case .dimension:
                return UIColor.systemGreen
            }
        }
        
        
        
    }
    
        
    
        init(type: `Type`, value:String){
            self.type = type
            self.value = value
        }
}
