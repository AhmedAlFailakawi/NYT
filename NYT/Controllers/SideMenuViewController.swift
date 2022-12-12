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
        label.textColor = UIColor.white
        label.font = UIFont(name: "Ubuntu", size: 17.0)
        label.text = "Ahmed AlFailakawi"
        
        return label
    }()
    
    var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.frame.size.width = 70
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "Ahmed")
        // Make Image Corners Rounded
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor(displayP3Red: 226 / 255, green: 220 / 255, blue: 200 / 255, alpha: 1.0).cgColor
        
        return imageView
    }()
    
    var separatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(displayP3Red: 226 / 255, green: 220 / 255, blue: 200 / 255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 17, weight: .ultraLight)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "_________________________________"
        
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
        table.register(SideMenuCellView.self, forCellReuseIdentifier: SideMenuCellView.cellIdentifier)
        table.rowHeight = 50
        table.separatorColor = UIColor(displayP3Red: 226 / 255, green: 220 / 255, blue: 200 / 255, alpha: 1.0)
        table.backgroundColor = UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
        table.showsVerticalScrollIndicator = false
        
        return table
    }()
    
    var segmentView: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Light", "Dark"])
        view.frame = CGRectMake(60, 250, 200, 30)
        view.selectedSegmentIndex = 0
        view.addTarget(SideMenuViewController.self, action: #selector(changeAppearance(_:)), for: .touchUpInside)
        
        return view
    }()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the view
        self.view.backgroundColor = UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
        
        // Table view
        tableView.dataSource = self
        tableView.delegate = self
        
        setup()
        
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
    }
    
}

// MARK: - Methods
extension SideMenuViewController {
    
    @objc func changeAppearance(_ sender: Any) {
        
    }
    
    func setup() {
        self.view.addSubview(avatar)
        self.view.addSubview(titleLabel)
        self.view.addSubview(separatorLabel)
        self.view.addSubview(tableView)
        self.view.addSubview(segmentView)
        configure()
    }
    
    func configure() {
        avatar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(20)
            make.height.width.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(125)
            make.leading.equalTo(avatar.snp.leading).offset(90)
        }
        
        separatorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(separatorLabel.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(50)
            make.trailing.leading.equalToSuperview()
        }
        
        segmentView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
//            make.top.equalTo(tableView.snp.bottom).offset(10)
            
        }
        
    }
    
}

// MARK: - Table view data source
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideMenuListViewModel.getOptions().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCellView.cellIdentifier, for: indexPath) as? SideMenuCellView else {fatalError("ArticleCellView not found")}
        
        // menu view model
        var sideMenu = [SideMenu]()
        sideMenu = SideMenuListViewModel.getOptions()
        
        // Pass data
        cell.cellTitleLabel.text = sideMenu[indexPath.row].labelText
        cell.iconView.image = sideMenu[indexPath.row].icon
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
}
