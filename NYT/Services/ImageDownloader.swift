//
//  ImageDownloader.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/13/22.
//
import Foundation
import Kingfisher
import UIKit
// Used for table view cells rounded thumbnails
struct ImageDownloader {
    func getImageWithDownsampling(imageUrlString: String, cell: ArticleTableViewCell) {
        guard let url = URL(string: imageUrlString) else { return }
        let processor = DownsamplingImageProcessor(size: cell.articleThumbnail.bounds.size)
        cell.articleThumbnail.kf.indicatorType = .activity
        cell.articleThumbnail.kf.setImage(with: url,
                                          options: [
                                            .processor(processor),
                                            .scaleFactor(UIScreen.main.scale),
                                            .cacheOriginalImage
                                          ])
    }
}
