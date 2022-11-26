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
        textView.textAlignment = .left
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
        textView.textAlignment = .left
        textView.font = UIFont.systemFont(ofSize: 14.0)
        textView.contentMode = .scaleToFill
        textView.isSelectable = true
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.text = "Random Text Generator is a web application which provides true random text which you can use in your documents or web designs. How does it work? First we took many books available on project Gutenberg and stored their contents in a database. Then a computer algorithm takes the words we stored earlier and shuffles them into sentences and paragraphs.The algorithm takes care to create text that looks similar to an ordinary book but without any real meaning. The reason we want our text to be meaningless is that we want the person viewing the resulting random text to focus on the design we are presenting, rather than try to read and understand the text."
        
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
        scrollView.isPagingEnabled = false
        scrollView.showsVerticalScrollIndicator = true
        
        configure()
        abstractTextView.text.append("""
                                     The New York Times is an American daily newspaper based in New York City with a worldwide readership. It was founded in 1851 by Henry Jarvis Raymond and George Jones, and was initially published by Raymond, Jones & Company. The newspaper's influence grew in 1870 and 1871, when it published a series of exposés on William Tweed, leader of the city's Democratic Party — popularly known as ""Tammany Hall"" (from its early-19th-century meeting headquarters) — that led to  the end of the Tweed Ring's domination of New York's City Hall. In the 1880s, The New York Times gradually transitioned from supporting Republican Party candidates in its editorials to becoming more politically independent and analytical.[32] In 1884, the paper supported Democrat Grover Cleveland (former mayor of Buffalo and governor of New York) in his first presidential campaign.[33] While this move cost The New York Times a portion of its readership among its more Republican readers (revenue declined from $188,000 to $56,000 from 1883 to 1884), the paper eventually regained most of its lost ground within a few years.[34]
                                     """)
        
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
            make.left.right.bottom.top.equalToSuperview()
        }
        
        // Content view
        contentView.snp.makeConstraints { make in
            make.bottom.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(1500)
        }
        
        // Stack view
        stackView.snp.makeConstraints { make in
            make.right.left.bottom.top.equalToSuperview()
        }
        
        // Thumbnail View
        thumbnailView.snp.makeConstraints { make in
            make.left.right.bottom.top.equalToSuperview()
        }
        
        imageParentView.snp.makeConstraints { make in
            make.height.equalTo(250)
            make.left.right.top.equalToSuperview()
        }
        
        // Title label
        titleLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(15)
            make.bottom.top.equalToSuperview()
        }
        
        titleParentView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.left.right.equalToSuperview()
            make.top.equalTo(imageParentView.snp.bottom)
        }
        
        // Date label
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
        
        // Separator label
        separatorLabel.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        separatorParentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(dateParentView.snp.bottom)
            make.height.equalTo(30)
            
        }
        
        // Abstract text view
        abstractTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        abstractParentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(separatorParentView.snp.bottom)
        }
        
        // Random text view
        randomTextView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        creditsParentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(abstractParentView.snp.bottom)
        }
        
    }
}

extension DetailsViewController {
    //    @IBAction func newspaperBarButtonPressed(_ sender: Any) {
    //        UIApplication.shared.open(url)
    //    }
    
}
