//
//  Character.swift
//  CombineUIKit
//
//  Created by Deisy Melo on 23/07/21.
//

import Foundation

enum CharacterStatus: String, Decodable {
    case dead = "Dead"
    case alive = "Alive"
    case unknown = "Unknown"
}

struct CharacterLocation: Decodable {
    let name: String
    let url: String
}

struct CharacterOrigin: Decodable {
    let name: String
    let url: String
}

struct Character: Decodable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: String
    let origin: CharacterOrigin
    let location: CharacterLocation
    let urlImage: String
    let episodes: [String]
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status
        case species
        case gender
        case origin
        case location
        case urlImage = "url"
        case episodes = "episode"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        status = try container.decode(CharacterStatus.self, forKey: .status)
        species = try container.decode(String.self, forKey: .species)
        gender = try container.decode(String.self, forKey: .gender)
        origin = try container.decode(CharacterOrigin.self, forKey: .origin)
        location = try container.decode(CharacterLocation.self, forKey: .location)
        urlImage = try container.decode(String.self, forKey: .urlImage)
        episodes = try container.decode([String].self, forKey: .episodes)
    }
}
