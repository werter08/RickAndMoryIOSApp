//
//  RMCharacters.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 28.03.2025.
//

struct RMLocation : Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
