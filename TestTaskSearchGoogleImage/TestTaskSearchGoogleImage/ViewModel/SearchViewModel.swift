//
//  SearchViewModel.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 06.02.23.
//

import Foundation

final class SearchViewModel {
    
    private let networkService = NetworkService()
    var pictures = Dynamic([Picture]())
    
    //Updating array of image search results
    func userSearching(searchText: String) {
        networkService.fetchPictures(searchText: searchText) { [weak self] searchResult in
            self?.pictures.value = searchResult?.imagesResults ?? []
        }
    }
}
