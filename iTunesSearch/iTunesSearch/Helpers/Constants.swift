//
//  Constants.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/2/23.
//

import Foundation

struct Constants {
    
    struct ITunesAPIs {
        // https://itunes.apple.com/search?entity=musicArtist&term=jack+johnson
        static let artistSearchbaseURL          = "https://itunes.apple.com/search"

        static let artistEntityQueryKey         = "entity"
        static let artistEntityQueryValue       = "musicArtist"
        static let artistTermQueryKey           = "term"
        
        // https://itunes.apple.com/search?entity=album&attribute=artistTerm&term=jack+johnson
        static let allAlbumsBaseURL             = "https://itunes.apple.com/search"

        static let allAlbumsEntityQueryKey      = "entity"
        static let allAlbumsEntityQueryValue    = "album"
        static let allAlbumsAttributeQueryKey   = "attribute"
        static let allAlbumsAttributeQueryValue = "artistTerm"
        static let allAlbumsArtistNameQueryKey  = "term"
        
        // https://itunes.apple.com/search?entity=song&attribute=albumTerm&term=On+And+On
        static let songsOnAlbumBaseURL              = "https://itunes.apple.com/search"

        static let songsOnAlbumEntityQueryKey       = "entity"
        static let songsOnAlbumEntityQueryValue     = "song"
        static let songsOnAlbumAttributeQueryKey    = "attribute"
        static let songsOnAlbumAttributeQueryValue  = "albumTerm"
        static let songsOnAlbumAlbumNameQueryKey    = "term"
    }
    
    struct Error {
        static let unknownError = "Unknown error. The issue is being worked on."
    }
}

