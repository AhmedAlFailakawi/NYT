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
    let standardThumbnail = "Standard Thumbnail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTitleAndAbstract()
        //setupImages()
    }
}
// MARK: - Set up
extension ArticlesViewController {
    func setupTitleAndAbstract() {
        NetworkManager().getNews { [weak self] (results) in
            switch results {
            case .success(let data):
                self?.articleListVM = ArticleListViewModel(articles: data.article!)
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
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        print(indexPath.count)
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.abstractLabel.text = articleVM.abstract
        guard let imageString = articleVM.article.media?.first?.mediaMetadata?.first?.url else {return cell}
        imageSetUp(imageUrlString: imageString, cell: cell)
        
        return cell
    }
    
    // if you click, go to the article's url
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Pressed cell no: \(indexPath.row)")
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        // deselect
        tableView.deselectRow(at: indexPath, animated: true)
        // open url
        UIApplication.shared.open(articleVM.url)
        
    }
}

extension ArticlesViewController {
    func imageSetUp(imageUrlString: String, cell: ArticleTableViewCell) {
        guard let url = URL(string: imageUrlString) else { return }
        
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    cell.articleThumbnail.image = loadedImage
                }
            }
        }
    }
}
