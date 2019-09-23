//
//  UIDevice+screenSize.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

public enum ScreenSize {
    case small
    case normal
}

public extension UIDevice {
    var screenSize: ScreenSize {
        return UIScreen.main.bounds.width <= 320 ? .small : .normal
    }
}

