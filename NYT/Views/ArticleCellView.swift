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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
//        imageView.image = UIImage(named: "defaultThumbnail")
        
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleToFill
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.backgroundColor = .gray
        return stack
    }()
    
    
    // MARK: - *** Methods ***
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.kf.cancelDownloadTask()
        thumbnailImageView.image = nil
    }
    
    func configure() {
        contentView.addSubview(self.thumbnailImageView)
        contentView.addSubview(stackView)
        //        stackView.addSubview(articleCellView.titleLabel)
        //        stackView.addSubview(articleCellView.abstractLabel)
        

        self.thumbnailImageView.snp.makeConstraints {
            $0.left.equalToSuperview().inset(10)
            //            $0.top.bottom.equalToSuperview()
            $0.width.height.equalTo(100)
            $0.centerY.equalTo(stackView.snp.centerY)
            
        }
        
        stackView.snp.makeConstraints {
            $0.left.equalTo(self.thumbnailImageView.snp.right).offset(10)
//            $0.right.equalToSuperview()
            $0.trailing.equalToSuperview().offset(10)
            $0.top.bottom.equalTo(self.thumbnailImageView)
        }
    }
    
    func makeRoundedThumbnail() {
        thumbnailImageView.frame.size.width = 100
        thumbnailImageView.layer.cornerRadius = thumbnailImageView.frame.size.width  / 2
        thumbnailImageView.clipsToBounds = true
    }
    
}
