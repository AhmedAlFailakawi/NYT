//
//  Article.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/6/22.
//

import Foundation

struct ArticleList: Decodable {
    let status: String?
    let article: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case article = "results"
    }
    
}

struct Article: Decodable {
    let title: String
    let abstract: String
}

