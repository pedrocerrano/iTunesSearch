//
//  SelectedArtistAlbumsVC.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/2/23.
//

import UIKit

class SelectedArtistAlbumsVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumListTableView: UITableView!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        albumListTableView.dataSource   = self
        albumListTableView.delegate     = self
        fetchAllAlbumsByArtist()
    }
    
    
    //MARK: - PROPERTIES
    var artist: Artist?
    var albums: [Album] = []
    
    
    //MARK: - FUNCTIONS
    func fetchAllAlbumsByArtist() {
        guard let artist = artist else { return }
        NetworkService.fetchAllAlbums(forArtist: artist) { [weak self] result in
            switch result {
            case .success(let albums):
                self?.albums = albums                
                DispatchQueue.main.async {
                    self?.artistNameLabel.text = artist.artistName
                    self?.albumListTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAlbumDetailVC" {
            guard let index = albumListTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? AlbumDetailVC else { return }
            let album = albums[index.row]
            destinationVC.album = album
        }
    }
} //: CLASS



//MARK: - EXT: TableView DataSource
extension SelectedArtistAlbumsVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let album = albums[indexPath.row]
        cell.updateUI(forAlbum: album)
        
        return cell
    }
}
