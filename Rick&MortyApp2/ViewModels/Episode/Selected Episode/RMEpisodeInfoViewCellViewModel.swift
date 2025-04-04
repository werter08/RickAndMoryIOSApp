//
//  RMCharacterInfoViewCell.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 30.03.2025.
//

import UIKit

final class RMEpisodeInfoViewCellViewModel {
    
    private let type: `Type`
    private let value:String
    
 
    
    public var toShowTitle:String{
        
        return type.GetToShowTitle
    }
    public var toShowValue:String{
    
        if value.isEmpty{
            return "None"
        }
        return value
    }
    public var toShowColor:UIColor{
        
        return type.GetToShowColor
    }
    
    
    enum `Type`:String{
        case air_date
        case name
        case episode
        case totalCharacter
        
        var GetToShowTitle:String {
            switch self{
            case .air_date,.name,.episode: return rawValue.uppercased()
            case .totalCharacter: return "TOTAL CHARACTERS"
            }
        }
        var GetToShowImage:UIImage?{
            switch self{
            case .air_date:
                return UIImage(systemName: "bell")
         
            case .episode:
                return UIImage(systemName: "bell")
            case .name:
                return UIImage(systemName: "bell")
            case .totalCharacter:
                return UIImage(systemName: "bell")
            }
        }
        var GetToShowColor:UIColor {
            switch self{
            case .air_date:
                return UIColor.systemRed
            case .episode:
                return UIColor.systemMint
            case .name:
                return UIColor.systemPink
            case .totalCharacter:
                return UIColor.systemGreen
            }
        }
        
        
        
    }
    
        
    
        init(type: `Type`, value:String){
            self.type = type
            self.value = value
        }
}
