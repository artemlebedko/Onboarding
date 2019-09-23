//
//  UIColor+rgba.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

extension UIColor {
    
    //MARK: - Init from Hex String
    convenience init(hexString: String, alpha: CGFloat = 1) {
        let newString = hexString + "FF"
        
        if let rgbaValue = UInt32(newString, radix: 16) {
            let red   = CGFloat((rgbaValue >> 24) & 0xff) / 255.0
            let green = CGFloat((rgbaValue >> 16) & 0xff) / 255.0
            let blue  = CGFloat((rgbaValue >>  8) & 0xff) / 255.0
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            self.init(red: 255, green: 255, blue: 255, alpha: 1)
        }
    }
}
