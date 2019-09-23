//
//  ColorScheme.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

final class ColorScheme {
    static let shared = ColorScheme()
    private init() {}
    
    let red = UIColor(hexString: "FB5C3F")
    let brandOrange = UIColor(hexString: "FC921f")
    let yellow = UIColor(hexString: "FFC658")
    let green = UIColor(hexString: "63B463")
    let blue = UIColor(hexString: "4174D6")
    let storm = UIColor(hexString: "323C5D")
    let skylight = UIColor(hexString: "DFE6F4")
    let darkSnow = UIColor(hexString: "F0F3F7")
    let snow = UIColor(hexString: "F7F8FA")
    let morningGlow = UIColor(hexString: "F8F8F8")
    let dayLight = UIColor(hexString: "FCFDFF")
    let white = UIColor.white
    let clear = UIColor.clear
}

