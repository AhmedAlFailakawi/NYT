//
//  App.swift
//  NYT
//
//  Created by Ahmed AlFailakawi on 12/12/22.
//

import Foundation
import UIKit
import LanguageManager_iOS

/// Appearance, background & foreground colors
struct AppColors {
    static let backgroundColor: UIColor = UIColor(displayP3Red: 44 / 255, green: 51 / 255, blue: 51 / 255, alpha: 1.0)
    static let foregroundColor: UIColor =  UIColor(displayP3Red: 226 / 255, green: 220 / 255, blue: 200 / 255, alpha: 1.0)
    /// Light | Dark | System
    static var appAppearance = 2 // Default value = System Appearance
}

struct AppLanguage {
    static var currnetLanguage: Languages = .en
}
