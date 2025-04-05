//
//  RMSettingsViewViewModul.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 04.04.2025.
//

import UIKit


struct RMSettingsCellViewModul: Identifiable {
    var id = UUID()
    
    public var type: RMSettingsOptions
    public var onTapHandler: (RMSettingsOptions) -> Void
    public var title:String {
        return type.titleLabel
    }
    
    public var icon:UIImage? {
        return type.titleIcon
    }

    public var color:UIColor {
        return type.iconFrameColor
    }

    public var url:URL? {
        return type.link
    }
    init(type: RMSettingsOptions, onTapHandler: @escaping (RMSettingsOptions) -> Void) {
        
        self.type = type
        self.onTapHandler = onTapHandler
    }
}
