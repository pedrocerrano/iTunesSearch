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
        albumTableView.dataSource = self
        albumTableView.delegate   = self
    }
    


    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        "toAlbumDetailVC"
    }
} //: CLASS


//MARK: - EXT: TableView DataSource
extension ArtistSearchVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "albumCell", for: indexPath) as? AlbumTableViewCell else { return UITableViewCell() }
        
        
        
        return cell
    }
    
    
}
