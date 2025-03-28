//
//  RMCharacters.swift
//  Rick&MortyApp2
//
//  Created by Shirin-Yan on 28.03.2025.
//

struct RMCharacter : Codable {
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMCharacterOrigin
    let location: RMCharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
}

struct RMCharacterLocation : Codable {
    let name: String
    let url: String
}
struct RMCharacterOrigin : Codable {
    let name: String
    let url: String
}


enum RMCharacterGender : String, Codable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}
enum RMCharacterStatus : String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"

}
