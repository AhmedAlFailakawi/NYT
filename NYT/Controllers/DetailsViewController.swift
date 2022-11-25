//
//  DetailsViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/14/22.
//
import Foundation
import UIKit
import Kingfisher

class DetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractTextView: UITextView!
    @IBOutlet weak var newspaperBarButton: UIBarButtonItem!
    @IBOutlet weak var thumbnailView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    private var articleListVM: ArticleListViewModel!
    var titleText: String = ""
    var abstractText: String = ""
    var date: String = ""
    var url: URL = URL(string: "https://www.nytimes.com")!
    var imageUrl: URL = URL(string: "https://static01.nyt.com/vi-assets/images/share/1200x1200_t.png")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "The New York Times"
        
        titleLabel.text = titleText
        abstractTextView.text = abstractText
        dateLabel.text = date
        thumbnailView.kf.indicatorType = .activity
        thumbnailView.kf.setImage(with: imageUrl,options: [.scaleFactor(UIScreen.main.scale),.cacheOriginalImage])
    }
    
    
    @IBAction func newspaperBarButtonPressed(_ sender: Any) {
        UIApplication.shared.open(url)
    }
}
