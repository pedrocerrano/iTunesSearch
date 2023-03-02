//
//  Artist.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/2/23.
//

import Foundation

struct ArtistTopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case searchArtistResults = "results"
    }
    
    let searchArtistResults: [Artist]
}

struct Artist: Decodable {
    let artistName: String
    let artistID: Int
    let primaryGenreName: String
}
