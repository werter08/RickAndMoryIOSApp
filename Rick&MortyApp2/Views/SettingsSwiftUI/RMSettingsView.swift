//
//  RMSettingsView.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 04.04.2025.
//

import SwiftUI

struct RMSettingsView: View {
    
    let viewModel:RMSettingsViewViewModel
    
    init(viewModel: RMSettingsViewViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.viewCells) { model in
            HStack{
                if let image = model.icon {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 20, height: 20)
                        .padding(5)
                        .background(Color(model.color))
                        .cornerRadius(8)
                    
                }
                Text(model.title)
                    .padding(.leading, 10)
                Spacer()
                    
                    
                    
            }
            
            .padding(5)
            .onTapGesture {
                model.onTapHandler(model.type)
            }
            
        }
    }
}

#Preview {
    RMSettingsView(viewModel: .init(viewCells: RMSettingsOptions.allCases.compactMap({
        return RMSettingsCellViewModul(type: $0){opiton in
        }
    })))
}
