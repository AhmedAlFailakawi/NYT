//
//  NotificationsViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/15/22.
//

import Foundation
import UIKit
import Lottie
import SnapKit

class NotificationsViewController: UIViewController {
    
    // MARK: - **** Properties ****
    private let animationView = LottieAnimationView(name: "notifications")
    
    var noNewsLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor(named: "AccentColor")
        
        if AppLanguage.currnetLanguage == .ar {
            label.textAlignment = .right
        } else {
            label.textAlignment = .left
        }
        label.numberOfLines = 0
        
        return label
    }()
    
    // MARK: - View did load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "News"
        
        animationView.frame = CGRect(x: 0, y: 100, width: self.view.frame.size.width, height: 100)
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        view.addSubview(noNewsLabel)
        
        configure()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Check appearance
        switch AppColors.appAppearance {
        case 0:
            overrideUserInterfaceStyle = .light
        case 1:
            overrideUserInterfaceStyle = .dark
        default:
            overrideUserInterfaceStyle = .unspecified
            
        }
        
        if AppLanguage.currnetLanguage == .en {
            noNewsLabel.text = "No notifications"
            noNewsLabel.font = UIFont(name: "Ubuntu", size: 15.0)
            
        } else {
            noNewsLabel.text = "لا توجد إشعارات"
            noNewsLabel.font = UIFont(name: "TheSansArabic Light", size: 15.0)
        }
        
    }
}

extension NotificationsViewController {
    
    /// Setup constraints for animation view and UILabelView.
    func configure() {
        animationView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.bottom.equalTo(noNewsLabel.snp.top)
        }
        
        noNewsLabel.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(70)
        }
    }
    
}
