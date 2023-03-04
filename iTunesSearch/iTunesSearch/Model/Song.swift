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
        case songName           = "trackName"
        case songNumber         = "trackNumber"
        case songLength         = "trackTimeMillis"
        case songArtistName     = "artistName"
        case songFromAlbumName  = "collectionName"
    }
    
    let songName: String
    let songNumber: Int
    let songLength: Int
    let songArtistName: String
    let songFromAlbumName: String
}
