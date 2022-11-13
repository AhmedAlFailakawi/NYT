//
//  NewYorkTimesAPI.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/5/22.
//

import Foundation
import Moya

enum NewYorkTimesAPI {
    case articles
}

extension NewYorkTimesAPI: TargetType {
    
    public var baseURL: URL {
        guard let url = URL(string: "https://api.nytimes.com/svc/") else { fatalError() }
        return url
    }
    
    public var path: String {
        switch self {
        case .articles:
            // don't add ? after json, it would get misinterpreted
            return "mostpopular/v2/viewed/7.json"
        }
    }
    public var method: Moya.Method {
        return .get
    }
    
    public var data: Data {
        return Data()
    }

    public var task: Moya.Task {
        return .requestParameters(parameters: ["api-key" : "VJpu2AKG82l1bFS4qEpNKOK09tySw9YC"], encoding: URLEncoding.default)
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
