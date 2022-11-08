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
        switch self {
        case .articles:
            guard let url = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/viewed/7.json?api-key=\(NetworkManager().apiKey)") else { fatalError() }
            return url
        }
    }
    
    public var path: String {
//        switch self {
//        case .articles:
//            return "/mostpopular/v2/viewed/7.json?api-key="
//        }
        return ""
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var data: Data {
        return Data()
    }
    
    public var task: Moya.Task {
        // NYT API doesn't require any additional request data to be passed
        // At leaset, that's what I know...
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
