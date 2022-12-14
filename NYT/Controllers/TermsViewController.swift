//
//  TermsViewController.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/14/22.
//
import Foundation
import UIKit
import RadioGroup
import SnapKit

class TermsViewController: UIViewController {
    // MARK: - **** Properties ****
    
    let radioButton = RadioGroup(titles: ["I reject this nonsense"])
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    var titleLabel: UILabel = {
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
    
    var termsAndConditionsTxtView: UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor(named: "AccentColor")
        
        if AppLanguage.currnetLanguage == .ar {
            textView.textAlignment = .right
        } else {
            textView.textAlignment = .left
        }
        
        textView.font = UIFont.systemFont(ofSize: 14.0)
        textView.contentMode = .scaleToFill
        textView.isSelectable = false
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.showsVerticalScrollIndicator = false
        textView.text = Bundle.main.localizedString(forKey: "termsText", value: nil, table: nil)
        
        return textView
    }()
    
    // MARK: - View did load
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.title = "The New York Times"
        
        scrollView.contentMode = .scaleToFill
        scrollView.isScrollEnabled = true
        scrollView.isPagingEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        
        radioButton.addTarget(self, action: #selector(agreePressed), for: .valueChanged)
        
        setup()
    }
    
    // MARK: - View will appear
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
            titleLabel.text = "Terms & Conditions"
            titleLabel.font = UIFont(name: "Ubuntu-Medium", size: 15.0)
            
        } else {
            titleLabel.text = "الضوابط والأحكام"
            titleLabel.font = UIFont(name: "TheSansArabic Light", size: 15.0)
        }
        
        // Deselected color
        radioButton.tintColor = AppColors.foregroundColor
        // Outter color
        radioButton.selectedTintColor = AppColors.foregroundColor
        // Inner color
        radioButton.selectedColor = AppColors.foregroundColor
        
        radioButton.titleAlignment = .natural
        if AppLanguage.currnetLanguage == .ar {
            radioButton.titles[0] = "أرفض هذا الهراء"
            radioButton.titleFont = UIFont(name: "TheSansArabic Light", size: 17.0)
//            radioButton.titleAlignment = .right
        } else {
            radioButton.titleFont = UIFont(name: "Ubuntu-Medium", size: 17.0)
        }
        
        radioButton.itemSpacing = 30
    }
}

extension TermsViewController {
    
    @objc func agreePressed() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        
        if radioButton.isSelected {
            radioButton.isSelected = false
        } else {
            radioButton.selectedIndex = 0
        }
    }
    
}

extension TermsViewController {
    /// Add subviews
    func setup() {
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(termsAndConditionsTxtView)
        contentView.addSubview(radioButton)
        configure()
        
    }
    
    /// Setup constraints
    func configure() {
        
        scrollView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.leading.trailing.bottom.top.equalToSuperview()
            make.height.equalTo(contentView.snp.height)
        }
        
        contentView.snp.makeConstraints { make in
            make.bottom.top.leading.trailing.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(80)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        termsAndConditionsTxtView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview()
        }
        
        radioButton.snp.makeConstraints { make in
            make.top.equalTo(termsAndConditionsTxtView.snp.bottom).offset(35)
            make.trailing.equalToSuperview()
            make.bottom.leading.equalToSuperview().inset(20)
        }
        
    }
    
}
