//
//  SideMenuViewModel.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/7/22.
//

import Foundation
import UIKit

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

// MARK: - ====== List View Model ======

struct SideMenuListViewModel {
     static func getOptions() -> [SideMenu] {
         let options = [
            SideMenu(icon: UIImage(named: "langauge"), labelText: "Change language"),
            SideMenu(icon: UIImage(named: "notifications"), labelText: "Notifications"),
            SideMenu(icon: UIImage(named: "terms"), labelText: "Terms & conditions"),
            SideMenu(icon: UIImage(named: "globe"), labelText: "Website")
        ]
         
         return options
    }
    
}

extension SideMenuListViewModel {
    
    var numberOfSections: Int {
        return 1
    }
    
    func numberOfRowsInSection() -> Int {
        return SideMenuListViewModel.getOptions().count
    }
    
    func optionAtIndex(_ index: Int) -> SideMenuViewModel {
        let option = SideMenuListViewModel.getOptions()[index]
        return SideMenuViewModel(option)
    }
    
}
