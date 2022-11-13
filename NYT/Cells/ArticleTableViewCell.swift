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
//        self.isHidden = true
        articleThumbnail.kf.cancelDownloadTask()
        articleThumbnail.image = nil
    }
}
