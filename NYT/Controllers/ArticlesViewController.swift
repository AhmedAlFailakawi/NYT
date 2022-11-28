//
//  ArticlesViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/5/22.
//
import Foundation
import SystemConfiguration
import UIKit
import Moya
import Kingfisher
import SnapKit

class ArticlesViewController: UITableViewController {
    // MARK: - *** Properties ***
    private var articleListVM: ArticleListViewModel!
    private let imageDownloader = ImageDownloader()
    private let articleCellView = ArticleCellView()
    private var didUpdateConstraints = false
    let refreshTableControl = UIRefreshControl()
    // For English = 0 , Arabic = 1
    var languageCode: String = "En"
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
        self.title = "The New York Times"
        self.navigationItem.setRightBarButton(UIBarButtonItem(title: "", image: UIImage(named: "language"), target: self, action: #selector(langaugeBarButtonPressed(_:))), animated: true)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 105
        tableView.register(ArticleCellView.self, forCellReuseIdentifier: ArticleCellView.cellIdentifier)
        
        showAlert()
        getArticles()
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        refreshTableControl.attributedTitle = NSAttributedString(string: "More bad news coming up...",attributes: attributes)
        refreshTableControl.tintColor = .white
        refreshTableControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.addSubview(refreshTableControl)
    }
    
    // MARK: - *** Methods ***
    @objc func refresh(sender: AnyObject) {
        print("Refreshing...")
        // Haptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        showAlert()
        getArticles()
        refreshTableControl.endRefreshing()
    }
    
    @objc func langaugeBarButtonPressed(_ sender: Any) {
        self.view.semanticContentAttribute = languageCode == "En" ? .forceRightToLeft : .forceLeftToRight
        navigationController?.view.semanticContentAttribute = languageCode == "En" ? .forceRightToLeft : .forceLeftToRight
        navigationController?.navigationBar.semanticContentAttribute = languageCode == "En" ? .forceRightToLeft : .forceLeftToRight
        
        
        if languageCode == "En" {
            languageCode = "Ar"
        } else {
            languageCode = "En"
        }
        // Pass language code to details VC
        DetailsViewController().languageCode = self.languageCode
    }
}

// MARK: - Get latest news
extension ArticlesViewController {
    func getArticles() {
        NetworkManager().getNews { [weak self] (results) in
            switch results {
            case .success(let data):
                self?.articleListVM = ArticleListViewModel(articles: data.articles!)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
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
        cell.titleLabel.text = "العنوان هو العنوان لأنه العنوان ولذلك العنوان هو العنوان"
//        cell.titleLabel.text = articleVM.title
        cell.abstractLabel.text = articleVM.abstract
        guard let imageString = articleVM.article.media?.first?.mediaMetadata?[1].url else {
            cell.thumbnailImageView.image = UIImage(named: "defaultThumbnail")?.preparingThumbnail(of: CGSize(width: 100, height: 100))
            return cell
        }
        
        imageDownloader.getImageWithDownsampling(imageUrlString: imageString, cell: cell)
        return cell
    }
    
    // *** Move to details VC ***
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        let detailsVC = DetailsViewController()
        
        guard let imageString = articleVM.article.media?.first?.mediaMetadata?[2].url else {
            // pass the data
            detailsVC.titleLabel.text = articleVM.title
            detailsVC.abstractTextView.text = articleVM.abstract
            detailsVC.dateLabel.text = articleVM.published_date
            detailsVC.url = articleVM.url
            
            self.navigationController?.pushViewController(detailsVC, animated: true)
            return
        }
        
        let url = URL(string: imageString)
        // pass the data
        detailsVC.imageUrl = url!
        detailsVC.titleLabel.text = articleVM.title
        detailsVC.abstractTextView.text = articleVM.abstract
        detailsVC.dateLabel.text = articleVM.published_date
        detailsVC.url = articleVM.url
        
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
