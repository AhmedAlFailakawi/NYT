//
//  NewYorkTimesAPI.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/5/22.
//

import Foundation
import Moya

struct APIResults: Decodable {
    // we have only one case
    let artciles: [Article]
}

public enum NewYorkTimesAPI: String, CodingKey {
    case articles = "results"
}

extension NewYorkTimesAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.nytimes.com/svc")!
    }
    
    public var path: String {
        switch self {
        case .articles:
            return "/mostpopular/v2/viewed/7.json?api-key="
        }
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
        return ["Content-Type": "application/json"]
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
    
}
// for testing
func stubbedResponse(_ filename: String) -> Data! {
    @objc class TestClass: NSObject { }
    
    let bundle = Bundle(for: TestClass.self)
    let path = bundle.path(forResource: filename, ofType: "json")
    return (try? Data(contentsOf: URL(fileURLWithPath: path!)))
}
