//
//  SearchResponse.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 06.02.23.
//

import Foundation

struct SearchResponse: Decodable {
    var imagesResults: [Picture]
}

struct Picture: Decodable {
    var thumbnail: String
    var original: String
    var link: String
}
