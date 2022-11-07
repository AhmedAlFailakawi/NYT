//
//  ViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/5/22.
//

import UIKit
import Moya

class ViewController: UIViewController {
    private var articleListVM: ArticleListViewModel!
    var newtworkProvider: Networkable!
    
    init(newtworkProvider: Networkable) {
        super.init(nibName: nil, bundle: nil)
        self.newtworkProvider = newtworkProvider
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented Idk why!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newtworkProvider.getNews(news: <#T##Article#>) { <#[Article]#> in
            <#code#>
        }
    }
    
    
}

