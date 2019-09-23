//
//  UIView+shadow.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

extension UIView {
    func drawShadow(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize? = CGSize(width: 0, height: 3)) {
        self.layer.shadowColor      = color.cgColor
        self.layer.shadowOffset     = offset!
        self.layer.shadowOpacity    = opacity
        self.layer.shadowRadius     = radius
        self.layer.masksToBounds    = false
    }
}

