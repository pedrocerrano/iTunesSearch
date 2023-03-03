//
//  NetworkService.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/2/23.
//

import Foundation

struct NetworkService {

    static func fetchArtists(forArtist artist: String, completion: @escaping (Result<ArtistTopLevelDictionary, NetworkError>) -> Void) {
        guard let baseURL   = URL(string: Constants.ITunesAPIs.artistSearchbaseURL) else { completion(.failure(.invalidURL)) ; return }
        var urlComponents   = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        
        let entityQuery     = URLQueryItem(name: Constants.ITunesAPIs.artistEntityQueryKey, value: Constants.ITunesAPIs.artistEntityQueryValue)
        let attributeQuery  = URLQueryItem(name: Constants.ITunesAPIs.artistAttributeQueryKey, value: Constants.ITunesAPIs.artistAttributeQueryValue)
        let termQuery       = URLQueryItem(name: Constants.ITunesAPIs.artistTermQueryKey, value: artist)
        urlComponents?.queryItems = [entityQuery, attributeQuery, termQuery]
        
        guard let finalURL = urlComponents?.url else { completion(.failure(.invalidURL)) ; return }
        print("fetchArtist Final URL: \(finalURL)")
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if let error = error {
                completion(.failure(.thrownError(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("fetchArtist Response Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(.failure(.noData)) ; return }
            do {
                let topLevel = try JSONDecoder().decode(ArtistTopLevelDictionary.self, from: data)
                completion(.success(topLevel))
            } catch {
                completion(.failure(.unableToDecode))
                print("...from fetchArtist data.")
            }
        }.resume()
    }
    
    
    static func fetchAllAlbums() {
        
    }
    
    
    static func fetchSongsForAlbum() {
        
    }
}
