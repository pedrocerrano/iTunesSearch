//
//  Album.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/2/23.
//

import Foundation

struct AlbumTopLevelDictionary: Decodable {
    private enum CodingKeys: String, CodingKey {
        case searchAlbumResults = "results"
    }
    
    let searchAlbumResults: [Album]
}

struct Album: Decodable {
    private enum CodingKeys: String, CodingKey {
        case albumArtistName  = "artistName"
        case albumName        = "collectionName"
        case albumID          = "collectionId"
        case albumArtwork     = "artworkUrl100"
        case albumReleaseYear = "releaseDate"
    }
    
    let albumArtistName: String
    let albumName: String
    let albumID: Int
    let albumArtwork: String
    let albumReleaseYear: String
}
