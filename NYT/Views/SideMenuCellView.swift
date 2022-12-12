//
//  SideMenuCellView.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/7/22.
//

import Foundation
import UIKit
import SnapKit

class SideMenuCellView: UITableViewCell {
    
    static let cellIdentifier = "SideMenuCellView"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI elements
    var iconView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
    
    var cellTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Ubuntu", size: 14)
        
        return label
    }()
    
}

// MARK: - ======== Constraints ===========
extension SideMenuCellView {
    
    func setup() {
        self.addSubview(iconView)
        self.addSubview(cellTitleLabel)
        configure()
    }

    func configure() {
        iconView.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        cellTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
    
}
