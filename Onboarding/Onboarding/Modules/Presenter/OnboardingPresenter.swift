//
//  OnboardingPresenter.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class OnboardingPresenter: OnboardingModuleInput, OnboardingViewOutput, OnboardingInteractorOutput {
    
    weak var view: OnboardingViewInput!
    var interactor: OnboardingInteractorInput!
    var router: OnboardingRouterInput!
    
    func openTabBar(navigationController: UINavigationController?) {
        if let navigationControllerUnwrapped = navigationController {
            router.routeToTabBar(navigationController: navigationControllerUnwrapped)
        }
    }
}

