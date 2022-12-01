//
//  GreetingsViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/1/22.
//

import UIKit
import SnapKit

class GreetingsViewController: UIViewController {

    let launchButton: UIButton = {
        let button = UIButton()
        button.setTitle("🚀", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.addTarget(GreetingsViewController.self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
        
        return button
    }()
    
    // MARK: - *** view did load ***
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setup()
    }
    
    // MARK: - *** Methods ***
    
    // set up views
    func setup() {
        self.view.addSubview(launchButton)
        configure()
    }
    
    // add constraints
    func configure() {
        launchButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            
        }
    }
    
    @objc func buttonPressed(_ sender: Any) {
        let viewController = ArticlesViewController(nibName: nil, bundle: nil)
        self.present(viewController, animated: true, completion: nil)
    }

}
