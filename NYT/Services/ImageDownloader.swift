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
    func getImageWithDownsampling(imageUrlString: String, cell: ArticleCellView) {
        guard let url = URL(string: imageUrlString) else { return }
        let processor = DownsamplingImageProcessor(size: cell.thumbnailImageView.bounds.size)
        cell.thumbnailImageView.kf.indicatorType = .activity
        cell.thumbnailImageView.kf.setImage(with: url,
                                          options: [
                                            .processor(processor),
                                            .scaleFactor(UIScreen.main.scale),
                                            .cacheOriginalImage
                                          ])
    }
}
