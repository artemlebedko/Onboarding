//
//  OnboardingInitializer.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class OnboardingModuleInitializer: NSObject {
    
    //Connect with object on storyboard
    @IBOutlet weak var onboardingViewController: OnboardingViewController!
    
    convenience init(window: UIWindow?) {
        self.init()
        
        let sb = UIStoryboard(name: "Onboarding", bundle: nil)
        onboardingViewController = sb.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController
        
        let configurator = OnboardingModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: onboardingViewController)
        
        
        window?.rootViewController = UINavigationController(rootViewController: onboardingViewController)
        window?.makeKeyAndVisible()
    }
    
}

