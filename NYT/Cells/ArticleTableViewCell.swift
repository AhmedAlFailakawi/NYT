//
//  ArticleTableViewCell.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/7/22.
//

import Foundation
import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var abstractLabel: UILabel!
    @IBOutlet weak var articleThumbnail: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        articleThumbnail.kf.cancelDownloadTask()
        articleThumbnail.image = nil
    }
    
    func makeRoundedThumbnail() {
        articleThumbnail.frame.size.width = 200
        articleThumbnail.layer.cornerRadius = 50
        articleThumbnail.clipsToBounds = true
    }
}
