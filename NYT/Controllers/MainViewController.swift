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
        label.font = UIFont(name: "Ubuntu", size: 17.0)
        label.text = "Greetings, Ahmed!"
        
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
        imageView.layer.borderColor = UIColor(displayP3Red: 226 / 255, green: 220 / 255, blue: 200 / 255, alpha: 1.0).cgColor
        
        return imageView
    }()
    
    var loginButtom: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("Let's read", for: .normal)
        button.tintColor = UIColor(displayP3Red: 226 / 255, green: 220 / 255, blue: 200 / 255, alpha: 1.0)
        button.setTitleColor(UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0), for: .normal)
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
        self.view.backgroundColor = UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
        self.title = "The New York Times"
        self.navigationItem.setLeftBarButton(UIBarButtonItem(image: UIImage(named: "menu"), style: .plain, target: self, action: #selector(menuBarButtonPressed)), animated: true)
        
        avatar.center = self.view.center
        sideMenuSetup()
        setup()
        loginButtom.addTarget(self, action: #selector(loginPressed(_:)), for: .touchUpInside)
        loginButtom.addTarget(self, action: #selector(pressCancelled(_:)), for: .touchCancel)
        
        //        arabicButton.addTarget(self, action: #selector(arabicPressed(_:)), for: .touchUpInside)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//            self.navigationController?.navigationBar.semanticContentAttribute = .forceLeftToRight
//            self.navigationController?.view.semanticContentAttribute = .forceLeftToRight
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        DispatchQueue.main.async {
            self.loginButtom.titleLabel?.font = UIFont(name: "Ubuntu", size: 16)
        }
        
    }
    
    
}

// MARK: - *** Methods ***

extension MainViewController {
    // set up views
    func setup() {
        self.view.addSubview(welcomeLabel)
        self.view.addSubview(avatar)
        self.view.addSubview(loginButtom)
        configure()
    }
    
    // add constraints
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
        sideMenu.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
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
        present(sideMenu, animated: true)
        
    }
    
    @objc func loginPressed(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
        let viewController = ArticlesViewController(nibName: nil, bundle: nil)
        ArticlesViewController.currnetLanguage = .en
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func pressCancelled(_ sender: Any) {
        self.loginButtom.titleLabel?.font = UIFont(name: "Ubuntu", size: 16)
    }
    
    //    @objc func arabicPressed(_ sender: Any) {
    //        let generator = UIImpactFeedbackGenerator(style: .light)
    //        generator.prepare()
    //        generator.impactOccurred()
    //        let viewController = ArticlesViewController(nibName: nil, bundle: nil)
    //        ArticlesViewController.currnetLanguage = .ar
    //        self.navigationController?.pushViewController(viewController, animated: true)
    //
    //    }
    
}

extension MainViewController: SideMenuNavigationControllerDelegate {
    
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        //        print("SideMenu Appearing! (animated: \(animated))")
    }
    
    func sideMenuDidAppear(menu: SideMenuNavigationController, animated: Bool) {
        //        print("SideMenu Appeared! (animated: \(animated))")
    }
    
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        //        print("SideMenu Disappearing! (animated: \(animated))")
    }
    
    func sideMenuDidDisappear(menu: SideMenuNavigationController, animated: Bool) {
        //        print("SideMenu Disappeared! (animated: \(animated))")
    }
}
