//
//  DetailsViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/14/22.
//
import Foundation
import UIKit

class DetailsViewController: UIViewController {
    private var articleListVM: ArticleListViewModel!
    private var detailsVM: DetailsViewModel!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractTextView: UITextView!
    @IBOutlet weak var newspaperBarButton: UIBarButtonItem!
    var titleText: String = ""
    var abstractText: String = ""
    var image: UIImage = UIImage(named: "defaultThumbnail")!
    var url: URL = URL(string: "https://www.nytimes.com")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleText
        abstractTextView.text = abstractText
        thumbnailView.image = image
        
        getArticles()
    }
    
    @IBAction func newspaperBarButtonPressed(_ sender: Any) {
        UIApplication.shared.open(url)
    }
}
// - MARK: Get data
extension DetailsViewController {
    func getArticles() {
        NetworkManager().getNews { [weak self] (results) in
            switch results {
            case .success(let data):
                self?.articleListVM = ArticleListViewModel(articles: data.article!)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
