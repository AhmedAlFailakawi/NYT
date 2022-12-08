//
//  SideMenuCellView.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/7/22.
//

import Foundation
import UIKit
import SnapKit
import SideMenu

class SideMenuCellView: UITableViewVibrantCell {
    
    static let cellIdentifier = "SideMenuCellView"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI elements
    var iconView: UIImageView = {
       let image = UIImageView()
//        image.contentMode = .scaleAspectFill
//        image.frame.size.width = 50
//        image.layer.cornerRadius = image.frame.size.width / 2
//        image.clipsToBounds = true
        
        return image
    }()
    
    var labelView: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = UIColor(named: "AccentColor")
        label.font = UIFont.systemFont(ofSize: 13.0, weight: .medium)
        
        return label
    }()
    
}

// MARK: - ======== Constraints ===========
extension SideMenuCellView {
    func configure() {
        
    }
}
