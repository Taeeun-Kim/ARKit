//
//  UIDevice+Extension.swift
//  MonthlyWallet
//
//  Created by Taeeun Kim on 12.08.21.
//

import SwiftUI

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            return keyWindow?.safeAreaInsets.bottom ?? 0 > 0
        }
        return false
    }
    
    //: Usage
//    if UIDevice.current.hasNotch {
//        Text("Text")
//    }
}

struct Screen {
     static var width = UIScreen.main.bounds.width
     static var height = UIScreen.main.bounds.height
     static var hasNotch = UIDevice.current.hasNotch
}
