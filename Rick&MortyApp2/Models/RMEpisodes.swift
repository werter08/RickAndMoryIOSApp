//
//  RMCharacters.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 28.03.2025.
//

struct RMEpisode : Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}


