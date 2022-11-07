//
//  Article.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/6/22.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let abstract: String
}

