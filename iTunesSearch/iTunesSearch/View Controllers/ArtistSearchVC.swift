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
    @IBOutlet weak var artistListTableView: UITableView!
    
    
    //MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        artistListTableView.dataSource   = self
        artistListTableView.delegate     = self
        artistSeatchBar.delegate    = self
        configureNavBarUI()
    }
    
    
    //MARK: - PROPERTIES
    var artistTopLevel: ArtistTopLevelDictionary?
    var artists: [Artist] = []
    
    
    //MARK: - FUNCTIONS
    func configureNavBarUI() {
        let label = UILabel()
        label.text = "Scottify"
        let labelButtonTrick = UIBarButtonItem(customView: label)
        navigationItem.leftBarButtonItem = labelButtonTrick
        
        let logo = UIImageView()
        logo.image = UIImage(named: "scottifyLogoClearSmall")
        let logoButtonTrick = UIBarButtonItem(customView: logo)
        navigationItem.rightBarButtonItem = logoButtonTrick
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectedArtistAlbumsVC" {
            guard let index = artistListTableView.indexPathForSelectedRow,
                  let destinationVC = segue.destination as? SelectedArtistAlbumsVC else { return }
            let artist = artists[index.row]
            destinationVC.artist = artist
        }
    }
} //: CLASS


//MARK: - EXT: TableView DataSource
extension ArtistSearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "artistCell", for: indexPath) as? ArtistsTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let artist = artists[indexPath.row]
        cell.updateUI(withArtist: artist)
        
        return cell
    }
}


//MARK: - EXT: SearchBar
extension ArtistSearchVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        NetworkService.fetchArtists(searchText: searchText) { [weak self] result in
            switch result {
            case .success(let topLevel):
                self?.artists.removeAll()
                self?.artistTopLevel = topLevel
                self?.artists = topLevel.searchArtistResults.filter({ artist in
                    artist.artistType == "Artist"
                })
                DispatchQueue.main.async {
                    self?.artistListTableView.reloadData()
                }
                
            case .failure(let error):
                print(error.errorDescription ?? Constants.Error.unknownError)
            }
        }
    }
}
