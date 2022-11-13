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

class ArticlesViewController: UITableViewController {
    private var articleListVM: ArticleListViewModel!
    private let imageDownloader = ImageDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAlert()
        getArticles()
    }    
}

// MARK: - Get latest news
extension ArticlesViewController {
    func getArticles() {
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
// MARK: - Table view setup
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
//        cell.isHidden = false
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.abstractLabel.text = articleVM.abstract
        guard let imageString = articleVM.article.media?.first?.mediaMetadata?.first?.url else {return cell}
        imageDownloader.getImageWithDownsampling(imageUrlString: imageString, cell: cell)
        
        return cell
    }
    
    // If you click, it'll direct you the article's url
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        // Deselect row
        tableView.deselectRow(at: indexPath, animated: true)
        // open url
        UIApplication.shared.open(articleVM.url)
        
    }
}
// MARK: - No internet connection methods
extension ArticlesViewController {
    func isInternetAvailable() -> Bool
        {
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
