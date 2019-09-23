//
//  OnboardingRouter.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class OnboardingRouter: OnboardingRouterInput {
    
    static var window: UIWindow?
    
    class func createOnboardingModule(window: UIWindow?) {
        OnboardingRouter.window = window
        _ = OnboardingModuleInitializer(window: window)
    }
    
    
    class func pushToOnboardingModule(navigationController: UINavigationController) {
        if let vc = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingViewController {
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    func routeToTabBar(navigationController: UINavigationController) {
        //MARK: - push your controller here
    }
}
