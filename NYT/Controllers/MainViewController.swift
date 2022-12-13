//
//  MainViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/1/22.
//
import Foundation
import UIKit
import SnapKit
import SideMenu

class MainViewController: UIViewController {
    
    enum MenuStatus {
        case opened
        case closed
    }
    
    // MARK: - *** Properties ***
    
    private var menuStatus: MenuStatus = .closed
    private let sideMenu = SideMenuNavigationController(rootViewController: SideMenuViewController())
    
    var welcomeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        
        return label
    }()
    
    var avatar: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size.width = 90
        imageView.frame.size.height = 90
        imageView.image = UIImage(named: "Ahmed")
        // Make Image Corners Rounded
        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = AppColors.foregroundColor.cgColor
        
        return imageView
    }()
    
    var loginButtom: UIButton = {
        let button = UIButton(configuration: .filled())
        button.tintColor = AppColors.foregroundColor
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 10.0
        button.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
        
        return button
    }()
    
    
    // MARK: - *** viewDidLoad ***
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = AppColors.backgroundColor
        self.title = "The New York Times"
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(menuBarButtonPressed)), animated: true)
        
        avatar.center = self.view.center
        
        sideMenuSetup()
        setup()
        
        loginButtom.addTarget(self, action: #selector(loginPressed(_:)), for: .touchUpInside)
                
    }
    
    // MARK: - ***** View will appear ****
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Welcome message
        if AppLanguage.currnetLanguage == .en {
            welcomeLabel.font = UIFont(name: "Ubuntu", size: 17.0)
            welcomeLabel.text = "Greetings, Ahmed!"
        } else {
            welcomeLabel.font = UIFont(name: "TheSansArabic Light", size: 17.0)
            welcomeLabel.text = "مرحبًا أحمد !"
        }
        
        // Start button
        if AppLanguage.currnetLanguage == .en {
            let attributedFont = [NSAttributedString.Key.font: UIFont(name: "Ubuntu-Medium", size: 16.0), NSAttributedString.Key.foregroundColor: AppColors.backgroundColor]
            
            let attributedString = NSAttributedString(string: "Let's read", attributes: attributedFont as [NSAttributedString.Key : Any])
                        
            self.loginButtom.setAttributedTitle(attributedString, for: .normal)
    
        } else { // Arabic
            
            let attributedFont = [NSAttributedString.Key.font: UIFont(name: "TheSansArabic Light", size: 17.0), NSAttributedString.Key.foregroundColor: AppColors.backgroundColor]
            
            let attributedString = NSAttributedString(string: "هيا نقرأ", attributes: attributedFont as [NSAttributedString.Key : Any])
                        
            self.loginButtom.setAttributedTitle(attributedString, for: .normal)
            
        }
        
        sideMenuSetup()
        // This is to remove "Back" word from the navigation arrow
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
}

// MARK: - *** Methods ***

extension MainViewController {
    /// Set up views
    func setup() {
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(avatar)
        self.view.addSubview(loginButtom)
        configure()
    }
    
    /// Add constraints
    func configure() {
        welcomeLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(avatar.snp.top).inset(240)
        }
        
        avatar.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(90)
        }
        
        loginButtom.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(25)
            make.top.equalTo(avatar.snp.bottom).offset(200)
            make.height.equalTo(50)
        }
        
    }
    
    func sideMenuSetup() {
//        sideMenu.leftSide = true
        if AppLanguage.currnetLanguage == .en {
            sideMenu.leftSide = true
            SideMenuManager.default.leftMenuNavigationController = sideMenu
        } else {
            sideMenu.leftSide = false
            SideMenuManager.default.rightMenuNavigationController = sideMenu
        }
        
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        sideMenu.presentationStyle = .menuSlideIn
        sideMenu.presentationStyle.backgroundColor = .black
        sideMenu.presentationStyle.presentingEndAlpha = 0.7
        sideMenu.statusBarEndAlpha = 0.0
        sideMenu.menuWidth = (UIScreen.main.bounds.width / 5) * 4
    }
    
    // MARK: - *** Side menu button ***
    @objc func menuBarButtonPressed() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
        
        if AppLanguage.currnetLanguage == .en {
            sideMenu.leftSide = true
        } else {
            sideMenu.leftSide = false
        }
        
        present(sideMenu, animated: true)
        
    }
    
    @objc func loginPressed(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        
        let viewController = ArticlesViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
