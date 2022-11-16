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
    private var detailsView = DetailsViewModel()
    private let detailsVC = DetailsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
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
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.abstractLabel.text = articleVM.abstract
        guard let imageString = articleVM.article.media?.first?.mediaMetadata?.first?.url else {
            cell.articleThumbnail.image = UIImage(named: "defaultThumbnail")?.preparingThumbnail(of: CGSize(width: 100, height: 100))
            cell.makeRoundedThumbnail()
            return cell
        }
        imageDownloader.getImageWithDownsampling(imageUrlString: imageString, cell: cell)
        cell.makeRoundedThumbnail()
        
        return cell
    }
    
    // If you click, it'll navigate to DetailsViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "DetailsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedPath = tableView.indexPathForSelectedRow else { return }
        let articleVM = self.articleListVM.articleAtIndex(selectedPath.row)
        
        if segue.identifier == "DetailsSegue", let nextVC = segue.destination as? DetailsViewController {
            nextVC.titleText = articleVM.title
            nextVC.abstractText = articleVM.abstract
            nextVC.url = articleVM.url
            // get image
            
        }
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
