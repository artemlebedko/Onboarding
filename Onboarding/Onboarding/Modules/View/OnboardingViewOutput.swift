//
//  OnboardingViewOutput.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

protocol OnboardingViewOutput {
    
    /**
     @author Artem Lebedko
     Notify presenter that view is ready
     */
    
    func openTabBar(navigationController: UINavigationController?)
}

