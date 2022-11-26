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
    let published_date: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case abstract
        case url
        case media
        case published_date
    }
}

struct ArticleList: Codable {
    let articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case articles = "results"
    }
}
