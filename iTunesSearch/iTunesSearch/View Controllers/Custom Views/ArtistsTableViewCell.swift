//
//  ArtistsTableViewCell.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/2/23.
//

import UIKit

class ArtistsTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var artistGenreLabel: UILabel!
    
    
    //MARK: - FUNCTIONS
    func updateUI(withArtist artist: Artist) {
        artistNameLabel.text    = artist.artistName.replacingOccurrences(of: "+", with: " ")
        artistGenreLabel.text   = artist.primaryGenreName
    }
}

// https://itunes.apple.com/search?entity=musicArtist&attribute=artistTerm&term=Ray+L
// https://itunes.apple.com/search?entity=musicArtist&attribute=artistTerm&term=Ray+L
