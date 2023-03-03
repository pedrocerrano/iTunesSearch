//
//  AlbumTableViewCell.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/1/23.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    
    //MARK: - FUNCTIONS
    func updateUI(forAlbum album: Album) {
        albumNameLabel.text = album.albumName
        NetworkService.fetchAlbumArtwork(forAlbum: album) { [weak self] result in
            switch result {
            case .success(let albumArt):
                DispatchQueue.main.async {
                    self?.albumImageView.image = albumArt
                }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }

}
