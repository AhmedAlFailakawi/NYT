//
//  SideMenuViewModel.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/7/22.
//

import Foundation
import UIKit
import LanguageManager_iOS

struct SideMenuViewModel {
    let sideMenu: SideMenu
    
    init(_ sideMenu: SideMenu) {
        self.sideMenu = sideMenu
    }
}

extension SideMenuViewModel {
    
    var icon: UIImage {
        return self.sideMenu.icon ?? UIImage(named: "")!
    }
    
    var label: String {
        return self.sideMenu.labelText ?? ""
    }
}

// MARK: - ====== List View Model =======
struct SideMenuListViewModel {
     static func getCells() -> [SideMenu] {
         // icons
         let language = UIImage(systemName: "character.bubble")?.withTintColor(.white, renderingMode: .alwaysOriginal)
         let notifications = UIImage(systemName: "envelope.badge")?.withTintColor(.white, renderingMode: .alwaysOriginal)
         let terms = UIImage(systemName: "text.book.closed")?.withTintColor(.white, renderingMode: .alwaysOriginal)
         let safari = UIImage(systemName: "safari")?.withTintColor(.white, renderingMode: .alwaysOriginal)
         
         // Check language
         if AppLanguage.currnetLanguage == .en {
             let cells = [
                SideMenu(icon: language, labelText: Bundle.main.localizedString(forKey: "lang", value: nil, table: nil), url: URL(string: "")),
                SideMenu(icon: notifications, labelText:  Bundle.main.localizedString(forKey: "notif", value: nil, table: nil), url: URL(string: "")),
                SideMenu(icon: terms, labelText:  Bundle.main.localizedString(forKey: "terms", value: nil, table: nil), url:  URL(string: "")),
                SideMenu(icon: safari, labelText: Bundle.main.localizedString(forKey: "web", value: nil, table: nil), url:  URL(string: "https://www.nytimes.com/international/"))
            ]
             
             return cells
             
         } else {
             let cells = [
                SideMenu(icon: language, labelText: Bundle.main.localizedString(forKey: "تغيير اللغة", value: nil, table: nil), url: URL(string: "")),
                SideMenu(icon: notifications, labelText:  Bundle.main.localizedString(forKey: "الاشعارات", value: nil, table: nil), url: URL(string: "")),
                SideMenu(icon: terms, labelText:  Bundle.main.localizedString(forKey: "الضوابط والأحكام", value: nil, table: nil), url:  URL(string: "")),
                SideMenu(icon: safari, labelText: Bundle.main.localizedString(forKey: "الموقع الرسمي", value: nil, table: nil), url:  URL(string: "https://www.nytimes.com/international/"))
            ]
             
             return cells
         }
         
    }
    
}

extension SideMenuListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return SideMenuListViewModel.getCells().count
    }
    
    func optionAtIndex(_ index: Int) -> SideMenuViewModel {
        let option = SideMenuListViewModel.getCells()[index]
        return SideMenuViewModel(option)
    }
    
}
