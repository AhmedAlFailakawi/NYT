//
//  Language.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 11/29/22.
//

import Foundation

enum Language: String {
    case english = "en"
    case arabic = "ar"
    
    var value: String {
        return self.rawValue
    }
}

extension Language {
    static func isArabic() -> Bool {
        return ArticlesViewController.currnetLanguage == Language.arabic
    }
    
    static func isEnglish() -> Bool {
        return ArticlesViewController.currnetLanguage == Language.english
    }
}

//extension Locale {
//    var isEnglish: Bool {
//        return languageCode == Language.english.rawValue
//    }
//}
