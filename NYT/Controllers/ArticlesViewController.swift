//
//  ArticlesViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/5/22.
//
import Foundation
import SystemConfiguration
import UIKit
import LanguageManager_iOS
import SkeletonView

class ArticlesViewController: UITableViewController {
    // MARK: - *** Properties ***
    
    public var articleListVM: ArticleListViewModel!
    private let imageDownloader = ImageDownloader()
    private let articleCellView = ArticleCellView()
    private var didUpdateConstraints = false
    let refreshTableControl = UIRefreshControl()
    var languageCode: String =  LanguageManager.shared.deviceLanguage!.rawValue
    static var currnetLanguage: Languages = .en
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(ArticlesViewController.currnetLanguage)
        LanguageManager.shared.setLanguage(language: ArticlesViewController.currnetLanguage)
        navigationController?.navigationBar.semanticContentAttribute =  ArticlesViewController.currnetLanguage == .ar ? .forceRightToLeft :  .forceLeftToRight
        navigationController?.view.semanticContentAttribute =  ArticlesViewController.currnetLanguage == .ar ? .forceRightToLeft :  .forceLeftToRight
        
        // Set up the view
        self.view.backgroundColor = UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
        self.title = "The New York Times"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 105
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ArticleCellView.self, forCellReuseIdentifier: ArticleCellView.cellIdentifier)
        
//        showAlert()
//        getArticles()
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshTableControl.attributedTitle = NSAttributedString(string: "More bad news coming up...",attributes: attributes)
        refreshTableControl.tintColor = .white
        refreshTableControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshTableControl)
    }
    
    // MARK: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.isSkeletonable = true
        tableView.showAnimatedSkeleton(usingColor: .clouds, transition: .none)
        showAlert()
        getArticles()
    }
    
    // MARK: - *** Methods ***
    
    @objc func refresh(sender: AnyObject) {
        print("Refreshing 🥤")
        // Haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
        showAlert()
        getArticles()
        refreshTableControl.endRefreshing()
    }
    
     func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        self.tableView.scrollToRow(at: topRow, at: .top, animated: false)
    }
    
}

// MARK: - Get latest news

extension ArticlesViewController {
    func getArticles() {
        NetworkManager().getNews { [weak self] (results) in
            switch results {
            case .success(let data):
                self?.articleListVM = ArticleListViewModel(articles: data.articles!)
                self?.scrollToTop()
                DispatchQueue.main.async {
                    self?.tableView.stopSkeletonAnimation()
                    self?.view.hideSkeleton()
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension ArticlesViewController: SkeletonTableViewDataSource {

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return ArticleCellView.cellIdentifier
    }
    
//    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 6
//    }

}

// MARK: - Table view setup

extension ArticlesViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCellView.cellIdentifier, for: indexPath) as? ArticleCellView else { fatalError("ArticleCellView not found") }
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        
        // Arabic
        if ArticlesViewController.currnetLanguage == .ar {
            cell.titleLabel.text = "العنوان هو العنوان لأنه العنوان ولذلك العنوان هو العنوان"
            cell.titleLabel.textAlignment = .right
            cell.abstractLabel.text = Bundle.main.localizedString(forKey: "arabicTxt", value: nil, table: nil)
            cell.abstractLabel.textAlignment = .right
            
            // English
        } else {
            cell.titleLabel.text = articleVM.title
            cell.titleLabel.textAlignment = .left
            cell.abstractLabel.text = articleVM.abstract
            cell.abstractLabel.textAlignment = .left
        }
        
        guard let imageString = articleVM.article.media?.first?.mediaMetadata?[1].url else {
            cell.thumbnailImageView.image = UIImage(named: "defaultThumbnail")?.preparingThumbnail(of: CGSize(width: 100, height: 100))
            return cell
        }
        
        imageDownloader.getImageWithDownsampling(imageUrlString: imageString, cell: cell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        let detailsVC = DetailsViewController()
        
        guard let imageString = articleVM.article.media?.first?.mediaMetadata?[2].url else {
            // pass the data
            if ArticlesViewController.currnetLanguage == .ar {
                detailsVC.titleLabel.text = "العنوان هو العنوان لأنه العنوان ولذلك العنوان هو العنوان"
                detailsVC.titleLabel.textAlignment = .right
                detailsVC.abstractTextView.textAlignment = .right
                detailsVC.randomTextView.textAlignment = .right
            } else {
                detailsVC.titleLabel.text = articleVM.title
                detailsVC.abstractTextView.text = articleVM.abstract
                detailsVC.titleLabel.textAlignment = .left
                detailsVC.abstractTextView.textAlignment = .left
                detailsVC.randomTextView.textAlignment = .left
            }
            
            detailsVC.dateLabel.text = articleVM.published_date
            detailsVC.url = articleVM.url
            detailsVC.languageCode = self.languageCode
            self.navigationController?.pushViewController(detailsVC, animated: true)
            return
        }
        
        let url = URL(string: imageString)
        // pass the data
        detailsVC.imageUrl = url!
        if ArticlesViewController.currnetLanguage == .ar {
            detailsVC.titleLabel.text = "العنوان هو العنوان لأنه العنوان ولذلك العنوان هو العنوان"
            detailsVC.titleLabel.textAlignment = .right
            detailsVC.abstractTextView.textAlignment = .right
            detailsVC.randomTextView.textAlignment = .right
        } else {
            detailsVC.titleLabel.text = articleVM.title
            detailsVC.abstractTextView.text = articleVM.abstract
            detailsVC.titleLabel.textAlignment = .left
            detailsVC.abstractTextView.textAlignment = .left
            detailsVC.randomTextView.textAlignment = .left
            
        }
        
        detailsVC.dateLabel.text = articleVM.published_date
        detailsVC.url = articleVM.url
        detailsVC.languageCode = self.languageCode
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
}

// MARK: - No internet connection methods using SystemConfiguration

extension ArticlesViewController {
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    func showAlert() {
        if !isInternetAvailable() {
            let alert = UIAlertController(title: "Oops!", message: "Please, check your internet connection", preferredStyle: .alert)
            let action = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
}
