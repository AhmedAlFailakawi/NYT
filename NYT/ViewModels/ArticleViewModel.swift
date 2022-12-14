//
//  ArticleViewModel.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/6/22.
//

import Foundation

// MARK: - Article List View Model
struct ArticleListViewModel {
    let articles: [Article]
}

extension ArticleListViewModel {
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index: Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
}

// - MARK: - Article View Model
struct ArticleViewModel {
     let article: Article
}

extension ArticleViewModel {
    init(_ article: Article) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: String {
        return self.article.title ?? ""
    }
    
    var abstract: String {
        return self.article.abstract ?? ""
    }
    
    var url: URL {
        return self.article.url ?? URL(string: "")!
    }
    
    var published_date: String {
        return self.article.published_date ?? ""
    }
}
