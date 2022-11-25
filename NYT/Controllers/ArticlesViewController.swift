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
    
    // move it to ArticleCellView
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleToFill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.backgroundColor = .gray
        return stack
    }()
    
    var didSetupConstraints = false
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ArticleCellView.self, forCellReuseIdentifier: ArticleCellView.cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 105
        self.title = "The New York Times"
        
        setup()
        showAlert()
        getArticles()
        //   self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    
    func setup() {
        self.view.addSubview(articleCellView)
        articleCellView.addSubview(articleCellView.thumbnailImageView)
        articleCellView.addSubview(stackView)
        //        stackView.addSubview(articleCellView.titleLabel)
        //        stackView.addSubview(articleCellView.abstractLabel)
        

        articleCellView.thumbnailImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(10)
            //            $0.top.bottom.equalToSuperview()
            $0.width.height.equalTo(100)
//            $0.centerY.equalTo(stackView.snp.centerY)
            
        }
        
        stackView.snp.makeConstraints {
            $0.left.equalTo(articleCellView.thumbnailImageView.snp.right).offset(10)
//            $0.right.equalToSuperview()
            $0.trailing.equalToSuperview().offset(10)
            $0.top.bottom.equalTo(articleCellView.thumbnailImageView)
        }
    }
    
    //    @objc func refresh(sender: AnyObject) {
    //        print("Refreshing...")
    //        showAlert()
    //        getArticles()
    //        self.refreshControl?.endRefreshing()
    //    }
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCellView.cellIdentifier, for: indexPath) as? ArticleCellView else { fatalError("ArticleCellView not found") }
        
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        cell.titleLabel.text = articleVM.title
        cell.abstractLabel.text = articleVM.abstract
        guard let imageString = articleVM.article.media?.first?.mediaMetadata?[1].url else {
            cell.thumbnailImageView.image = UIImage(named: "defaultThumbnail")?.preparingThumbnail(of: CGSize(width: 100, height: 100))
            // cell.makeRoundedThumbnail()
            return cell
        }
        
        imageDownloader.getImageWithDownsampling(imageUrlString: imageString, cell: cell)
        //  cell.makeRoundedThumbnail()
        return cell
    }
    
    // If you click on cell, it'll navigate you to DetailsViewController by performing a segue.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let articleVM = self.articleListVM.articleAtIndex(indexPath.row)
        print(articleVM.url)
        //        UIApplication.shared.open(articleVM.url)
        //        self.performSegue(withIdentifier: "DetailsSegue", sender: self)
    }
}

// MARK: - Prepare for Segue
extension ArticlesViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsSegue" {
            let nextVC = segue.destination as? DetailsViewController
            
            guard let selectedPath = tableView.indexPathForSelectedRow else { return }
            let articleVM = self.articleListVM.articleAtIndex(selectedPath.row)
            
            nextVC?.titleText = articleVM.title
            nextVC?.abstractText = articleVM.abstract
            nextVC?.date = articleVM.published_date
            nextVC?.url = articleVM.url
            
            guard let imageString = articleVM.article.media?.first?.mediaMetadata?[2].url else { return }
            let url = URL(string: imageString)
            nextVC?.imageUrl = url!
        }
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
