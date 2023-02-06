//
//  SearchViewController.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 06.02.23.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        <#code#>
    }
}
