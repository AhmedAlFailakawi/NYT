//
//  Article.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/6/22.
//

import Foundation

struct Article: Codable {
    let title: String?
    let abstract: String?
    let url: URL?
    let media: [Media]?
    
    enum CodingKeys: String, CodingKey {
        case title
        case abstract
        case url
        case media        
    }
}

struct ArticleList: Codable {
    let article: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case article = "results"
    }
}
