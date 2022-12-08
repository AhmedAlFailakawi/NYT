//
//  SideMenuViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/7/22.
//

import Foundation
import UIKit
import SnapKit
import SideMenu

class SideMenuViewController: UIViewController {
    // MARK: - *** Properties ***
    public var sideMenuListVM: SideMenuListViewModel!
    
    // ^^^ Header ^^^
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont(name: "Ubuntu", size: 17.0)
        label.text = "Greetings, Ahmed!"
        
        return label
    }()
    
    var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame.size.width = 50
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    var separatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 17, weight: .ultraLight)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "________________________________"
        
        return label
    }()
    
    var stackView: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleToFill
        stack.distribution = .fillEqually
        stack.spacing = 20
        
        return stack
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the view
        self.view.backgroundColor = UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
        
        // Table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 105
        tableView.showsVerticalScrollIndicator = false
        tableView.register(ArticleCellView.self, forCellReuseIdentifier: ArticleCellView.cellIdentifier)
        
        
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
            return
        }
    }
    
}

// MARK: - Table view data source
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sideMenuListVM == nil ? 0 : self.sideMenuListVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCellView.cellIdentifier, for: indexPath) as? SideMenuCellView else {fatalError("ArticleCellView not found")}
        
        // menu
        guard let menu = navigationController as? SideMenuNavigationController else { return cell }
        cell.blurEffectStyle = menu.blurEffectStyle
        
        // menu view model
        let _ = self.sideMenuListVM.optionAtIndex(indexPath.row)
        
        
        
        return cell
    }
    
    
    
}
