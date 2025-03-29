//
//  RMCharacterSelectedViewViewModel.swift.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 29.03.2025.
//

final class  RMCharacterSelectedViewViewModel{
    private let char:RMCharacter
    public var title:String
    init(char: RMCharacter) {
        self.char = char
        title = char.name.uppercased()
    }
    
 
}
