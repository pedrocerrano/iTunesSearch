//
//  AlbumDetailVC.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/1/23.
//

import UIKit

class AlbumDetailVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var albumArtImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songListTableView: UITableView!
    
    
    //MARK: - LIFECYCE
    override func viewDidLoad() {
        super.viewDidLoad()
        songListTableView.dataSource = self
        songListTableView.delegate   = self
        updateUI()
    }
    
    
    //MARK: - PROPERTIES
    var album: Album?
    var songs: [Song] = []
    
    
    //MARK: - FUNCTIONS
    func updateUI() {
        guard let album = album else { return }
        albumNameLabel.text  = album.albumName
        artistNameLabel.text = album.albumArtistName
        
        NetworkService.fetchAlbumArtwork(forAlbum: album) { [weak self] result in
            switch result {
            case .success(let albumArt):
                DispatchQueue.main.async {
                    self?.albumArtImageView.image = albumArt
                }
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
        fetchSongs(fromAlbum: album)
    }
    
    
    func fetchSongs(fromAlbum album: Album) {
        NetworkService.fetchSongs(fromAlbum: album) { [weak self] result in
            switch result {
            case .success(let songs):
                self?.songs = songs.filter({ song in
                    album.albumName == song.songFromAlbumName
                })
                DispatchQueue.main.async {
                    self?.songListTableView.reloadData()
                }
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
} //: CLASS


//MARK: - EXT: TableView DataSource
extension AlbumDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongListTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let sortedSongs = songs.sorted {
            $0.songNumber < $1.songNumber
        }
        
        let song = sortedSongs[indexPath.row]
        cell.updateUI(withSong: song)
        
        return cell
    }
}
