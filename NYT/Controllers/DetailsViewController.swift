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
    private let button = UIBarButtonItem()
    
    // MARK: - *** UI Elements Views ***
    lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .natural
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
    
    lazy var separatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .ultraLight)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "________________________________"
        
        return label
    }()
    
    lazy var abstractTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor(named: "AccentColor")
        textView.textAlignment = .natural
        textView.font = UIFont.systemFont(ofSize: 14.0)
        textView.contentMode = .scaleToFill
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    lazy var randomTextView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor(named: "AccentColor")
        textView.textAlignment = .natural
        textView.font = UIFont.systemFont(ofSize: 14.0)
        textView.contentMode = .scaleToFill
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.text = localizedString(forKey: "random")
        
        return textView
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "The New York Times"
        self.view.backgroundColor = .systemBackground
        
        self.navigationItem.setRightBarButton(UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(readMoreBarButtonPressed(_:))), animated: true)
        
        if ArticlesViewController.currnetLanguage == .ar {
            navigationController?.view.semanticContentAttribute = .forceRightToLeft
            navigationController?.navigationBar.semanticContentAttribute = .forceRightToLeft
        } else { // English
            navigationController?.view.semanticContentAttribute = .forceLeftToRight
//            navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
        }
        
        scrollView.contentMode = .scaleToFill
        scrollView.indicatorStyle = .default
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        
        configure()
        abstractTextView.text.append(contentsOf: localizedString(forKey: "abstract"))
        randomTextView.text.append(contentsOf: localizedString(forKey: "random"))
        thumbnailView.kf.indicatorType = .activity
        thumbnailView.kf.setImage(with: imageUrl,options: [.scaleFactor(UIScreen.main.scale),.cacheOriginalImage])
        thumbnailView.clipsToBounds = true
        
    }
    
}

// MARK: - *** Configuration ***
extension DetailsViewController {
    func configure() {
        // *** Properties ***
        let contentView = UIView()
        let stackView = UIStackView()
        let imageParentView = UIView()
        let titleParentView = UIView()
        let dateParentView = UIView()
        let separatorParentView = UIView()
        let abstractParentView = UIView()
        let creditsParentView = UIView()
        
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
        
        stackView.addSubview(separatorParentView)
        separatorParentView.addSubview(separatorLabel)
        
        stackView.addSubview(abstractParentView)
        abstractParentView.addSubview(abstractTextView)
        
        stackView.addSubview(creditsParentView)
        creditsParentView.addSubview(randomTextView)
        
        // Constraints
        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.bottom.top.equalToSuperview()
            make.height.equalTo(contentView.snp.height).inset(225)
        }
        
        // Content view
        contentView.snp.makeConstraints { make in
            make.bottom.top.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        // Stack view
        stackView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        // Thumbnail View
        thumbnailView.snp.makeConstraints { make in
            make.leading.trailing.bottom.top.equalToSuperview()
        }
        
        imageParentView.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.leading.trailing.top.equalToSuperview()
        }
        
        // Title label
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15)
            make.bottom.top.equalToSuperview()
        }
        
        titleParentView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(imageParentView.snp.bottom)
        }
        
        // Date label
        dateLabel.snp.makeConstraints { make in
            make.trailing.lessThanOrEqualTo(309)
            make.leading.equalToSuperview().inset(15)
            make.bottom.top.equalToSuperview()
        }
        
        dateParentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleParentView.snp.bottom)
            make.height.equalTo(13)
        }
        
        // Separator label
        separatorLabel.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        separatorParentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(dateParentView.snp.bottom)
            make.height.equalTo(30)
            
        }
        
        // Abstract text view
        abstractTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        abstractParentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(separatorParentView.snp.bottom)
        }
        
        // Random text view
        randomTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        creditsParentView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(abstractParentView.snp.bottom)
        }
        
    }
}
// MARK: - *** Methods ***
extension DetailsViewController {
    
    @objc func readMoreBarButtonPressed(_ sender: Any) {
        UIApplication.shared.open(url)
    }
    
    func localizedString(forKey key: String) -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        
        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: "Default")
        }
        
        return result
    }
    
}
