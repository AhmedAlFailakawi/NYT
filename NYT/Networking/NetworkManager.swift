//
//  NetworkManager.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/7/22.
//

import Foundation
import Moya

protocol Networkable {
    func getNews(completion: @escaping (Result<ArticleList, Error>) -> ())
}

// MARK: - *** NetworkManager ***
struct NetworkManager: Networkable {
    private let provider = MoyaProvider<NewYorkTimesAPI>()
    
    func getNews(completion: @escaping (Result<ArticleList, Error>) -> ()) {
        provider.request(.articles) { result in
            switch result {
            case .success(let response):
                switch response.statusCode {
                case 200:
                    do {
                        let results = try JSONDecoder().decode(ArticleList.self, from: response.data)
                        // ^^^ tesing territory starts ^^^
//                        let hereToHelp = results.self.article?[0].media?.first?.mediaMetadata?.first?.url
//                        print(hereToHelp as Any)
                        // ^^^ tesing territory ends ^^^
                        completion(.success(results))
                    } catch let error {
                        print("You're going down according to the following exception :: \(error)")
                        completion(.failure(error))
                    }
                default:
                    do {
                        let errorResponse = try JSONDecoder().decode(ResponseError.self, from: response.data)
                        let error = NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey: errorResponse.fault.faultstring])
                        completion(.failure(error))
                    } catch let error {
                        completion(.failure(error))
                    }
                }
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
