//
//  ArtistSearchVC.swift
//  iTunesSearch
//
//  Created by iMac Pro on 3/1/23.
//

import UIKit

class ArtistSearchVC: UIViewController {

    //MARK: - OUTLETS
    @IBOutlet weak var artistSeatchBar: UISearchBar!
    @IBOutlet weak var albumTableView: UITableView!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        albumTableView.dataSource   = self
        albumTableView.delegate     = self
        artistSeatchBar.delegate    = self
    }
    
    
    //MARK: - PROPERTIES
    var artistTopLevel: ArtistTopLevelDictionary?
    var artists: [Artist] = []
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        "toAlbumDetailVC"
    }
} //: CLASS


//MARK: - EXT: TableView DataSource
extension ArtistSearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? ArtistsTableViewCell else { return UITableViewCell() }
        
        let artist = artists[indexPath.row]
        cell.updateUI(withArtist: artist)
        
        return cell
    }
}


//MARK: - EXT: SearchBar
extension ArtistSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkService.fetchArtists(forArtist: searchText) { result in
            switch result {
            case .success(let topLevel):
                self.artistTopLevel = topLevel
                self.artists = topLevel.searchArtistResults
                DispatchQueue.main.async {
                    self.albumTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
}
