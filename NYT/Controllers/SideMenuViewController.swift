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
    // ^^^ Header ^^^
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .natural
        label.textColor = UIColor.white
        
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
        imageView.layer.borderColor = AppColors.foregroundColor.cgColor
        
        return imageView
    }()
    
    var separatorLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColors.foregroundColor
        label.font = UIFont.systemFont(ofSize: 17, weight: .ultraLight)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "_________________________________"
        
        return label
    }()
    
    var tableView: UITableView = {
        let table = UITableView()
        table.register(SideMenuCellView.self, forCellReuseIdentifier: SideMenuCellView.cellIdentifier)
        table.rowHeight = 50
        table.separatorColor = AppColors.foregroundColor
        table.backgroundColor = AppColors.backgroundColor
        table.showsVerticalScrollIndicator = false
        table.isScrollEnabled = false
        
        return table
    }()
    
    var segmentView: UISegmentedControl = {
        let view = UISegmentedControl(items: ["Light", "Dark", "System"])
        view.frame = CGRectMake(0, 0, 90, 30)
        view.selectedSegmentIndex = 0
        view.selectedSegmentTintColor = AppColors.foregroundColor
        //        view.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: "Ubuntu-Medium", size: 14) as Any], for: .normal)
        
        return view
    }()
    
    // MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Set up the view
        self.view.backgroundColor = AppColors.backgroundColor
        
        // Segmented control
        segmentView.selectedSegmentIndex = 2
        segmentView.addTarget(self, action: #selector(changeAppearance), for: .valueChanged)
        segmentView.addTarget(self, action: #selector(changeAppearance), for: .touchUpInside)
        
        // Table view
        tableView.dataSource = self
        tableView.delegate = self
        
        setup()
        
    }
    
    // MARK: - View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if AppLanguage.currnetLanguage == .en {
            titleLabel.text = "Ahmed AlFailakawi"
            titleLabel.font = UIFont(name: "Ubuntu", size: 17.0)
            
        } else {
            titleLabel.text = "أحمد الفيلكاوي"
            titleLabel.font = UIFont(name: "TheSansArabic Light", size: 17.0)
        }
        
        // Segmented controll color setup
        let selectedTitleTextAttribute = [NSAttributedString.Key.foregroundColor: AppColors.backgroundColor, NSAttributedString.Key.font: UIFont(name: "Ubuntu-Medium", size: 14)]
        let normalTitleTextAttribute = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont(name: "Ubuntu-Medium", size: 14)]
        
        segmentView.setTitleTextAttributes(selectedTitleTextAttribute as [NSAttributedString.Key : Any], for: .selected)
        segmentView.setTitleTextAttributes(normalTitleTextAttribute as [NSAttributedString.Key : Any], for: .normal)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
}

extension SideMenuViewController {
    // MARK: - *** Light | Dark | System ***
    @objc func changeAppearance(sender: UISegmentedControl) {
        
        if segmentView.selectedSegmentIndex == 0 {
            // Switch to Light
            AppColors.appAppearance = 0
            
        } else if segmentView.selectedSegmentIndex == 1 {
            // Switch to Dark
            AppColors.appAppearance = 1
            
        } else {
            // Switch to System
            AppColors.appAppearance = 2
        }
        
    }
    
    // MARK: - *** Setup UI ***
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
            //            make.bottom.equalToSuperview().offset(50)
            make.height.equalTo(200)
            make.trailing.leading.equalToSuperview()
        }
        
        segmentView.snp.makeConstraints { make in
            make.top.equalTo(tableView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
    }
    
}

// MARK: - Table view data source
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SideMenuListViewModel.getCells().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // cell
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuCellView.cellIdentifier, for: indexPath) as? SideMenuCellView else {fatalError("ArticleCellView not found")}
        
        // menu view model
        var sideMenu = [SideMenu]()
        sideMenu = SideMenuListViewModel.getCells()
        
        if AppLanguage.currnetLanguage == .en {
            cell.cellTitleLabel.font = UIFont(name: "Ubuntu", size: 14)
        } else {
            cell.cellTitleLabel.font = UIFont(name: "TheSansArabic Light", size: 14)
        }
        
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
        
        // change language
        if indexPath.row == 0 {
            if AppLanguage.currnetLanguage == .ar {
                AppLanguage.currnetLanguage = .en
            } else {
                AppLanguage.currnetLanguage = .ar
            }
            
            let vc = ArticlesViewController(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // Terms & conditions
        if indexPath.row == 2 {
            let vc = TermsViewController(nibName: nil, bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        // to open website
        if indexPath.row == 3 {
            guard let url = SideMenuListViewModel.getCells()[3].url else { return }
            UIApplication.shared.open(url)
        }
        
    }
    
}
