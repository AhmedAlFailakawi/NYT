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
import SkeletonView

class ArticleCellView: UITableViewCell {
    // MARK: - *** Properties ***
    static let cellIdentifier = "ArticleTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.isSkeletonable = true
        contentView.isSkeletonable = true
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - *** UI Elements ***
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
//        label.isSkeletonable = true
        
        return label
    }()
    
    lazy var abstractLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.textAlignment = .natural
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.systemFont(ofSize: 12.0)
//        label.isSkeletonable = true

        return label
    }()
    
    lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame.size.width = 100
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true

        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleToFill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 20
        stack.isSkeletonable = true

        return stack
    }()
    
    // MARK: - *** Methods ***
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.kf.cancelDownloadTask()
        thumbnailImageView.image = nil
    }
    
    func configure() {
        // Adding subviews
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(stackView)
        stackView.addSubview(titleLabel)
        stackView.addSubview(abstractLabel)
        
        // Setting up the constraints
        thumbnailImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.width.height.equalTo(100)
            $0.centerY.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(thumbnailImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
            $0.top.bottom.equalTo(thumbnailImageView)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(2)
            $0.top.equalToSuperview().inset(10)
        }
        
        abstractLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(2)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().offset(2)
        }
        
    }
    
}
