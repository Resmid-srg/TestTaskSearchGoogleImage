//
//  SearchViewController.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 06.02.23.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {
    
    private var timer: Timer?
    
    let networkService = NetworkService()
   
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var pictures: [Picture] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.5), height: .fractionalHeight(1), spacing: 1)
        let fullItem = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(0.5), spacing: 1)
        let mainItem = CompositionalLayout.createItem(width: .fractionalWidth(1), height: .fractionalHeight(0.5), spacing: 1)
        
        let verticalGroup = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(0.5), height: .fractionalHeight(1), item: fullItem, count: 2)
        let horizontalGroup = CompositionalLayout.createGroup(alignment: .horizontal, width: .fractionalWidth(1), height: .fractionalHeight(0.5), items: [item, verticalGroup])
        let mainGroup = CompositionalLayout.createGroup(alignment: .vertical, width: .fractionalWidth(1), height: .fractionalHeight(0.8), items: [mainItem, horizontalGroup])
        
        let section = NSCollectionLayoutSection(group: mainGroup)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! SearchCollectionViewCell
        let picture = pictures[indexPath.row]
        AF.request(String(picture.thumbnail),method: .get).response { response in
            switch response.result {
            case .success(let responseData):
                cell.setup(image: UIImage(data: responseData!, scale: 1)!)
            case .failure(let error):
                print("Error: ",error)
            }
        }
        cell.backgroundColor = .blue
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            let url = "https://serpapi.com/search.json?q=\(searchText)&tbm=isch&ijn=0"
            
            AF.request(url).responseData { dataResponse in
                if let error = dataResponse.error {
                    print ("Error recieved requesting data: \(error.localizedDescription)")
                    return
                }
                
                guard let data = dataResponse.data else { return }
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let objects = try decoder.decode(SearchResponse.self, from: data)
                    self.pictures = objects.imagesResults
                    self.collectionView.reloadData()
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                }
            }
        })
    }
}
