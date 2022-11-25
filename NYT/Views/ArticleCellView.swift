//
//  ArticleCellView.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/21/22.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

class ArticleCellView: UITableViewCell {
    // MARK: - *** Properties ***
    static let cellIdentifier = "ArticleTableViewCell"
    
     lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17.0)
        
        return label
    }()
    
     lazy var abstractLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.systemFont(ofSize: 12.0)

        return label
    }()
    
     lazy var thumbnailImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
//        imageView.heightAnchor.constraint(equalToConstant: 100.0).isActive = true
//        imageView.widthAnchor.constraint(equalToConstant: 100.0).isActive = true
        imageView.frame.size.width = 100
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "defaultThumbnail")
        
        return imageView
    }()
    
    // MARK: - *** Methods ***
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.kf.cancelDownloadTask()
        thumbnailImageView.image = nil
    }
    
    func makeRoundedThumbnail() {
        thumbnailImageView.frame.size.width = 100
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.width  / 2
        thumbnailImageView.clipsToBounds = true
    }
    
}
