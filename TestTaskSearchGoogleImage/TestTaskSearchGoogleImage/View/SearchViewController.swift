//
//  SearchViewController.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 06.02.23.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {

    private let viewModel = SearchViewModel()
    private var pictures: [Picture] = []
    private var timer: Timer?

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        // Delegtes
        self.searchBar.delegate = self
        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        // Setups
        bindViewModel()
        collectionView.collectionViewLayout = createLayout()

        printMultithreading()

    }

    func printMultithreading() {
        let serialQueue = DispatchQueue(label: "serialQueue")
         serialQueue.async {
           print("test1")
         }
         print("test2")
    }

    // MARK: - Binding ViewModel

    func bindViewModel() {

        // Bind array of image search results
        viewModel.pictures.bind { [weak self] pictures in
            DispatchQueue.main.async {
                self?.pictures = pictures
                self?.collectionView.reloadData()
                self?.view.activityStopAnimating()
            }
        }
    }

    // MARK: - Setups Layout

    private func createLayout() -> UICollectionViewCompositionalLayout {
        let item = CompositionalLayout.createItem(width: .fractionalWidth(0.5),
                                                  height: .fractionalHeight(1),
                                                  spacing: 1)
        let fullItem = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                      height: .fractionalHeight(0.5),
                                                      spacing: 1)
        let mainItem = CompositionalLayout.createItem(width: .fractionalWidth(1),
                                                      height: .fractionalHeight(0.5),
                                                      spacing: 1)

        let verticalGroup = CompositionalLayout.createGroup(alignment: .vertical,
                                                            width: .fractionalWidth(0.5),
                                                            height: .fractionalHeight(1),
                                                            item: fullItem,
                                                            count: 2)
        let horizontalGroup = CompositionalLayout.createGroup(alignment: .horizontal,
                                                              width: .fractionalWidth(1),
                                                              height: .fractionalHeight(0.5),
                                                              items: [item, verticalGroup])
        let mainGroup = CompositionalLayout.createGroup(alignment: .vertical,
                                                        width: .fractionalWidth(1),
                                                        height: .fractionalHeight(0.8),
                                                        items: [mainItem, horizontalGroup])

        let section = NSCollectionLayoutSection(group: mainGroup)

        return UICollectionViewCompositionalLayout(section: section)
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegate

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictures.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage",
                                                            for: indexPath) as? SearchCollectionViewCell else { return
            collectionView.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath)
        }
        let picture = pictures[indexPath.row]
            cell.setup(imageThumbnailUrl: picture.thumbnail)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pictureDetailsVC = self.storyboard?.instantiateViewController(
            withIdentifier: "PictureDetailsViewController") as? PictureDetailsViewController
        if let pictureDetailsVC = pictureDetailsVC {
            pictureDetailsVC.currentPictureIndex = indexPath.row
            pictureDetailsVC.pictures = pictures
            self.navigationController?.pushViewController(pictureDetailsVC, animated: true)
        }
    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

//        let dispatchTimer = DispatchSource.makeTimerSource()
//
//        print("kek")
//        dispatchTimer.setEventHandler {
//            print("lol")
//            self.viewModel.userSearching(searchText: searchText)
//            self.view.activityStartAnimating()
//        }
//        dispatchTimer.schedule(deadline: .now() + 0.7, repeating: 6)
//        dispatchTimer.activate()

        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false, block: { [weak self] _ in
            self?.viewModel.userSearching(searchText: searchText)
            self?.view.activityStartAnimating()
        })
    }
}
