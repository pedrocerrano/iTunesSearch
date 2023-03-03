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
        case wrapperType
        case albumArtistName  = "artistName"
        case albumName        = "collectionName"
        case albumID          = "collectionId"
        case albumArtworkURL  = "artworkUrl100"
        case albumReleaseYear = "releaseDate"
    }
    
    let wrapperType: String
    let albumArtistName: String
    let albumName: String
    let albumID: Int
    let albumArtworkURL: String
    let albumReleaseYear: String
}

