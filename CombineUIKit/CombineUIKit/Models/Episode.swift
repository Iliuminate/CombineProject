//
//  Episode.swift
//  CombineUIKit
//
//  Created by Carlos Diaz on 23/07/21.
//

import Foundation

// -id         -int       The id of the episode.
// -name       -string    The name of the episode.
// -air_date   -string    The air date of the episode.
// -episode    -string    The code of the episode.
// -characters -array (urls)    List of characters who have been seen in the episode.
// -url        -string (url)    Link to the episode's own endpoint.
// -created    -string    Time at which the episode was created in the database.

struct Episode: Decodable {
    
    let id: Int
    let name: String
    let date: String
    let episode: String
    let characters: [String] // TODO: CEDA - chage to use Character model
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case date = "air_date"
        case episode
        case characters
        case url
    }
}
