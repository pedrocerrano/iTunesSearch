//
//  Song.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/2/23.
//

import Foundation

struct SongTopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case searchSongResults = "results"
    }
    
    let searchSongResults: [Song]
}

struct Song: Decodable {
    private enum CodingKeys: String, CodingKey {
        case trackName
        case trackNumber
        case trackLength = "trackTimeMillis"
    }
    
    let trackName: String
    let trackNumber: Int
    let trackLength: Int
}
