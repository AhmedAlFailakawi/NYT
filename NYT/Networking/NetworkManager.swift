//
//  NetworkManager.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/7/22.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<NewYorkTimesAPI> {get}
    func getNews(news: Article, completion: @escaping ([Article]) -> ())
}
// MARK: - *** NetworkManager ***
struct NetworkManager: Networkable {
    
    static let apiKey = "VJpu2AKG82l1bFS4qEpNKOK09tySw9YC"
    var provider = MoyaProvider<NewYorkTimesAPI>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])
    
    func getNews(news: Article, completion: @escaping ([Article]) -> ()) {
        provider.request(.article) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try JSONDecoder().decode(Article.self, from: response.data)
                } catch let error {
                    print("You're going down according to the following exception :: \(error)")
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
