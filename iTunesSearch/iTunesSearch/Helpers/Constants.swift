//
//  Constants.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/2/23.
//

import Foundation

struct Constants {
    
    struct ITunesAPIs {
        // https://itunes.apple.com/search?entity=musicArtist&attribute=artistTerm&term=u2
        static let artistSearchbaseURL          = "https://itunes.apple.com/search"
        static let artistEntityQueryKey         = "entity"
        static let artistEntityQueryValue       = "musicArtist"
        static let artistAttributeQueryKey      = "attribute"
        static let artistAttributeQueryValue    = "artistTerm"
        static let artistTermQueryKey           = "term"
        
        // https://itunes.apple.com/lookup?entity=album&id=78500
        static let allAlbumsBaseURL             = "https://itunes.apple.com/lookup"
        static let allAlbumsEntityQueryKey      = "entity"
        static let allAlbumsEntityQueryValue    = "album"
        static let allAlbumsArtistIdQueryKey    = "id"
        
        // https://itunes.apple.com/lookup?entity=song&id=1443155637
        static let songsOnAlbumBaseURL          = "https://itunes.apple.com/lookup"
        static let songsOnAlbumEntityQueryKey   = "entity"
        static let songsOnAlbumEntityQueryValue = "song"
        static let songsOnAlbumQueryKey         = "id"
    }
    
    struct Error {
        static let unknownError = "Unknown error. The issue is being worked on."
    }
}
