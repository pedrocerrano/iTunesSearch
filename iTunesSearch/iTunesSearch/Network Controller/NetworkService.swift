//
//  NetworkService.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/2/23.
//

import UIKit

struct NetworkService {

    static func fetchArtists(searchText search: String, completion: @escaping (Result<ArtistTopLevelDictionary, NetworkError>) -> Void) {
        guard let baseURL   = URL(string: Constants.ITunesAPIs.artistSearchbaseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents   = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let entityQuery     = URLQueryItem(name: Constants.ITunesAPIs.artistEntityQueryKey, value: Constants.ITunesAPIs.artistEntityQueryValue)
        let termQuery       = URLQueryItem(name: Constants.ITunesAPIs.artistTermQueryKey, value: search.replacingOccurrences(of: " ", with: "+"))
        urlComponents?.queryItems = [entityQuery, termQuery]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("fetch Artist Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { artistData, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("fetch Artist Response Status Code: \(response.statusCode)")
            }
            
            guard let data = artistData else { completion(.failure(.noData)) ; return }
            do {
                let topLevel = try JSONDecoder().decode(ArtistTopLevelDictionary.self, from: data)
                completion(.success(topLevel))
            } catch {
                completion(.failure(.unableToDecode))
                print("...from fetchArtist data.")
            }
        }.resume()
    }
    
    
    static func fetchAllAlbums(forArtist artist: Artist, completion: @escaping (Result<[Album], NetworkError>) -> Void) {
        guard let baseURL   = URL(string: Constants.ITunesAPIs.allAlbumsBaseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents   = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let entityQuery     = URLQueryItem(name: Constants.ITunesAPIs.allAlbumsEntityQueryKey, value: Constants.ITunesAPIs.allAlbumsEntityQueryValue)
        let attributeQuery  = URLQueryItem(name: Constants.ITunesAPIs.allAlbumsAttributeQueryKey, value: Constants.ITunesAPIs.allAlbumsAttributeQueryValue)
        let artistIdQuery   = URLQueryItem(name: Constants.ITunesAPIs.allAlbumsArtistNameQueryKey, value: "\(artist.artistName.replacingOccurrences(of: " ", with: "+"))")
        urlComponents?.queryItems = [entityQuery, attributeQuery, artistIdQuery]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Fetch AllAlbums Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { albumData, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetch AllAlbums Response Status Code: \(response.statusCode)")
            }
            
            guard let data = albumData else { completion(.failure(.noData)) ; return }
            do {
                let topLevel = try JSONDecoder().decode(AlbumTopLevelDictionary.self, from: data)
                completion(.success(topLevel.searchAlbumResults))
            } catch {
                completion(.failure(.unableToDecode))
                print("...from fetchAllAlbums data.")
            }
        }.resume()
    }
    
    
    static func fetchAlbumArtwork(forAlbum album: Album, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let finalURL = URL(string: album.albumArtworkURL) else { completion(.failure(.invalidURL)) ; return }
        print("Fetch AlbumArtwork Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { albumArtData, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetch AlbumArtwork Response Status Code: \(response.statusCode)")
            }
            
            guard let data       = albumArtData else { completion(.failure(.noData)) ; return }
            guard let albumImage = UIImage(data: data) else { completion(.failure(.unableToDecode)) ; return }
            completion(.success(albumImage))
        }.resume()
    }
    
    
    static func fetchSongs(fromAlbum album: Album, completion: @escaping (Result<[Song], NetworkError>) -> Void) {
        guard let baseURL   = URL(string: Constants.ITunesAPIs.songsOnAlbumBaseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents   = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let entityQuery     = URLQueryItem(name: Constants.ITunesAPIs.songsOnAlbumEntityQueryKey, value: Constants.ITunesAPIs.songsOnAlbumEntityQueryValue)
        let attributeQuery  = URLQueryItem(name: Constants.ITunesAPIs.songsOnAlbumAttributeQueryKey, value: Constants.ITunesAPIs.songsOnAlbumAttributeQueryValue)
        let albumNameQuery  = URLQueryItem(name: Constants.ITunesAPIs.songsOnAlbumAlbumNameQueryKey, value: album.albumName.replacingOccurrences(of: " ", with: "+"))
        urlComponents?.queryItems = [entityQuery, attributeQuery, albumNameQuery]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("Fetch Songs Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { songData, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Fetch Songs Response Status Code: \(response.statusCode)")
            }
            
            guard let data = songData else { completion(.failure(.noData)) ; return }
            do {
                let topLevel = try JSONDecoder().decode(SongTopLevelDictionary.self, from: data)
                completion(.success(topLevel.searchSongResults))
            } catch {
                completion(.failure(.unableToDecode))
                print("...from fetch Songs data.")
            }
        }.resume()
    }
}
