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
    
   // MARK: - *** Properties ***
    private var articleListVM: ArticleListViewModel!
    var titleText: String = ""
    var abstractText: String = ""
    var date: String = ""
    var url: URL = URL(string: "https://www.nytimes.com")!
    var imageUrl: URL = URL(string: "https://static01.nyt.com/vi-assets/images/share/1200x1200_t.png")!
    private let scrollView = UIScrollView()
    
    // *** UI Elements Views ***
    lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        label.numberOfLines = 0

        return label
    }()
    
    lazy var dateLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var seperatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .ultraLight)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = "________________________________"
        return label
    }()
    
    lazy var abstractTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor(named: "AccentColor")
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 14.0)
        textView.contentMode = .scaleToFill
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "The New York Times"
        self.view.backgroundColor = .systemBackground
        self.tabBarItem = UITabBarItem(title: "hi", image: .add, tag: 1)
        scrollView.contentMode = .scaleToFill
        scrollView.indicatorStyle = .default
        scrollView.isScrollEnabled = true
        
        configure()
        
        thumbnailView.kf.indicatorType = .activity
        thumbnailView.kf.setImage(with: imageUrl,options: [.scaleFactor(UIScreen.main.scale),.cacheOriginalImage])
        thumbnailView.clipsToBounds = true

    }
    
}

extension DetailsViewController {
//    @IBAction func newspaperBarButtonPressed(_ sender: Any) {
//        UIApplication.shared.open(url)
//    }
    
    func configure() {
        // *** Properties ***
        let contentView = UIView()
        let stackView = UIStackView()
        let imageParentView = UIView()
        let titleParentView = UIView()
        let dateParentView = UIView()
        let seperatorParentView = UIView()
        let abstractParentView = UIView()
        
        seperatorParentView.backgroundColor = .orange
        
        // Embed all subviews
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        
        stackView.addSubview(imageParentView)
        imageParentView.addSubview(thumbnailView)
        
        stackView.addSubview(titleParentView)
        titleParentView.addSubview(titleLabel)

        stackView.addSubview(dateParentView)
        dateParentView.addSubview(dateLabel)

        stackView.addSubview(seperatorParentView)
        seperatorParentView.addSubview(seperatorLabel)

        stackView.addSubview(abstractParentView)
        abstractParentView.addSubview(abstractTextView)

        // Constraints
        scrollView.snp.makeConstraints { make in
//            make.right.equalToSuperview()
//            make.left.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.left.right.bottom.top.equalTo(self.view.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints { make in
            make.left.right.equalTo(stackView)
            make.bottom.top.equalTo(stackView)
            make.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.right.left.bottom.top.equalToSuperview()
        }
        
        thumbnailView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        imageParentView.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.left.right.top.equalToSuperview()
        }

        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.top.equalToSuperview()
        }
        
        titleParentView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.left.right.equalToSuperview()
            make.top.equalTo(imageParentView.snp.bottom)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.right.lessThanOrEqualTo(309)
            make.left.equalToSuperview().inset(15)
            make.bottom.top.equalToSuperview()
        }
        
        dateParentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(titleParentView.snp.bottom)
            make.height.equalTo(13)
        }
        
        
        
    }
}
