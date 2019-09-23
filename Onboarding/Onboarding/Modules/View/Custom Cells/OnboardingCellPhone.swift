//
//  OnboardingCellPhone.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class OnboardingCellPhone: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var firstElement: UIImageView!
    @IBOutlet weak var secondElement: UIImageView!
    @IBOutlet weak var thirdElement: UIImageView!
    
    var panGesture: UIPanGestureRecognizer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        panGesture.delegate = self
        self.addGestureRecognizer(panGesture)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @objc private func  onPan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .ended:
            returnToBasePosition()
        case .changed:
            if firstElement.frame.origin.x >= (contentView.frame.width * 0.54) {
                firstElement.frame.origin.x -= 0.3
                secondElement.frame.origin.x += 0.3
            }
        default:
            break
        }
    }
    
    private func returnToBasePosition() {
        UIView.animate(withDuration: 0.3) {
            self.firstElement.frame.origin.x = self.thirdElement.frame.origin.x + 54
            self.secondElement.frame.origin.x = self.thirdElement.frame.origin.x - 39
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

