//
//  ArticlesViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/5/22.
//
import Foundation
import UIKit
import Moya

class ArticlesViewController: UITableViewController {
    private var articleListVM: ArticleListViewModel!
//    var newtworkManager: NetworkManager?
//
//    init(newtworkManager: NetworkManager) {
//        super.init(nibName: nil, bundle: nil)
//        self.newtworkManager = newtworkManager
//
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

extension ArticlesViewController {
    func setup() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager().getNews { [weak self] (results) in
            switch results {
            case .success(let data):
                self?.articleListVM = ArticleListViewModel(articles: data.article!)
                // For testing
                print(self?.articleListVM.articles as Any)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
// MARK: - UITable setup
extension ArticlesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        //print(self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections)
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.abstractLabel.text = articleVM.abstract
        return cell
    }
}
