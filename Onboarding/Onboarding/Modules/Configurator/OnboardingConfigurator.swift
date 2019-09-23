//
//  OnboardingConfigurator.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class OnboardingModuleConfigurator {
    
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        
        if let viewController = viewInput as? OnboardingViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: OnboardingViewController) {
        
        let router = OnboardingRouter()
        
        let presenter = OnboardingPresenter()
        presenter.view = viewController
        presenter.router = router
        
        let interactor = OnboardingInteractor()
        interactor.output = presenter
        
        presenter.interactor = interactor
        viewController.output = presenter
    }
    
}

