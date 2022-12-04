//
//  LanguageViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/1/22.
//
import Foundation
import UIKit
import SnapKit

class LanguageViewController: UIViewController {
    // MARK: - *** Properties ***
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.contentMode = .scaleToFill
        stack.distribution = .equalSpacing
        stack.spacing = 20
        
        return stack
    }()
    
    let englishButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("English", for: .normal)
        button.tintColor = UIColor(displayP3Red: 226 / 255, green: 220 / 255, blue: 200 / 255, alpha: 1.0)
        button.setTitleColor(UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0), for: .normal)
        return button
    }()
    
    let arabicButton: UIButton = {
        let button = UIButton(configuration: .filled())
        button.setTitle("العربية", for: .normal)
        button.tintColor = UIColor(displayP3Red: 226 / 255, green: 220 / 255, blue: 200 / 255, alpha: 1.0)
        button.setTitleColor(UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0), for: .normal)
        
        return button
    }()
    
    // MARK: - *** viewDidLoad ***
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
        self.title = "The New York Times"
        setup()
        
        englishButton.addTarget(self, action: #selector(englishPressed(_:)), for: .touchUpInside)
        arabicButton.addTarget(self, action: #selector(arabicPressed(_:)), for: .touchUpInside)
    }
    
}

    // MARK: - *** Methods ***

extension LanguageViewController {
    // set up views
    func setup() {
        self.view.addSubview(stackView)
        stackView.addSubview(englishButton)
        stackView.addSubview(arabicButton)
        configure()
    }
    
    // add constraints
    func configure() {
        
        stackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.trailing.leading.equalToSuperview().inset(60)
            make.bottom.equalToSuperview().inset(250)
            make.top.equalToSuperview().inset(250)
        }
        
        englishButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(70)
            make.top.equalToSuperview().inset(100)
            make.height.equalTo(30)
        }
        
        arabicButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(70)
            make.top.equalTo(englishButton.snp.bottom).offset(40)
            make.height.equalTo(englishButton.snp.height)
        }
        
    }
    
    @objc func englishPressed(_ sender: Any) {
        let viewController = ArticlesViewController(nibName: nil, bundle: nil)
        ArticlesViewController.currnetLanguage = .en
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func arabicPressed(_ sender: Any) {
        let viewController = ArticlesViewController(nibName: nil, bundle: nil)
        ArticlesViewController.currnetLanguage = .ar
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}
