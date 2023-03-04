//
//  SongListTableViewCell.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/3/23.
//

import UIKit

class SongListTableViewCell: UITableViewCell {

    //MARK: - OUTLETS
    @IBOutlet weak var songNumberLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songLengthLabel: UILabel!
    
    
    //MARK: - FUNCTIONS
    func updateUI(withSong song: Song) {
        songNameLabel.text = song.songName
        songNumberLabel.text    = "\(song.songNumber)"
        songLengthLabel.text    = song.songLength.minutesAndSeconds()
    }
}

