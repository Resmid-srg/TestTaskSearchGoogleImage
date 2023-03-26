//
//  NetworkService.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 06.02.23.
//

import Foundation
import Alamofire

class NetworkService {

    // MARK: - Getting search images from SerpApi

    func fetchPictures(searchText: String, completion: @escaping (SearchResponse?) -> Void) {
        let url = "https://serpapi.com/search.json"
        let params = ["q": "\(searchText)",
                      "tbm": "isch",
                      "ijn": "0",
                      "api_key": "013c18e03ec9c1cf21dd001f68793bca3728b30e8b0d8346681801466642261c"
        ]

        AF.request(url,
                   method: .get,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: nil)
        .responseData { dataResponse in
            if let error = dataResponse.error {
                print("Error recieved requesting data: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = dataResponse.data else { return }

            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let objects = try decoder.decode(SearchResponse.self, from: data)
                completion(objects)

            } catch let jsonError {
                print("Failed to decode JSON", jsonError)
                completion(nil)
            }
        }
    }
}
