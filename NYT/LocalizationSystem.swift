//
//  LocalizationSystem.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/29/22.
//

import Foundation
import UIKit

class LocalizationSystem: NSObject {
    
    var bundle: Bundle!
    var navigationController = UINavigationController()
    
    class var sharedInstance: LocalizationSystem {
        struct Singleton {
            static let instance: LocalizationSystem = LocalizationSystem()
        }
        return Singleton.instance
    }
    
    override init() {
        super.init()
        bundle = Bundle.main
    }
    
    func localizedStringForKey(key:String, comment:String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    // MARK: - setLanguage
    // Sets the desired language of the ones you have.
    // If this function is not called it will use the default OS language.
    // If the language does not exists y returns the default OS language.
    func setLanguage(languageCode: String) {
        var appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        appleLanguages.remove(at: 0)
        appleLanguages.insert(languageCode, at: 0)
        UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize() //needs restrat
        
        if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj")  {
            bundle = Bundle.init(path: languageDirectoryPath)
        } else {
            resetLocalization()
        }
    }
    
    // MARK: - resetLocalization
    //Resets the localization system, so it uses the OS default language.
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    // MARK: - getLanguage
    func start() {
        if let currentLanguge = UserDefaults.standard.string(forKey: "AppleLanguages") {
            print("current language: \(currentLanguge)")
            ArticlesViewController.currnetLanguage = Language.init(rawValue: currentLanguge)!
        } else {
            if let preferredLangauges = Locale.preferredLanguages.first?.prefix(2) {
                print("preferred language: \(preferredLangauges)")
                ArticlesViewController.currnetLanguage = Language(rawValue: String(preferredLangauges)) ?? .english
               

            }
        }
        reload()
    }
    
    func reload() {
        UIView.appearance().semanticContentAttribute = Language.isEnglish() ? .forceLeftToRight : .forceRightToLeft
        navigationController.view.semanticContentAttribute = Language.isEnglish() ? .forceLeftToRight : .forceRightToLeft
        navigationController.navigationBar.semanticContentAttribute = Language.isEnglish() ? .forceLeftToRight : .forceRightToLeft
        
    }

}
