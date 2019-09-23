//
//  OnboardingCellCar.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class OnboardingCellCar: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var firstElement: UIImageView!
    @IBOutlet weak var secondElement: UIImageView!
    @IBOutlet weak var thirdElement: UIImageView!
    
    let firstElementBasePositionX: CGFloat   = UIDevice.current.screenSize == .small ? 153.0 : 153.0
    let secondElementBasePositionX: CGFloat  = UIDevice.current.screenSize == .small ? 165.0 : 185.0
    let thirdElementBasePositionX: CGFloat   = UIDevice.current.screenSize == .small ? 104.0 : 104.0
    
    var panGesture: UIPanGestureRecognizer!
    var owner: OnboardingBaseCellOwner?
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    private func setupUI() {
        firstElement.frame = CGRect(x: firstElementBasePositionX, y: 97, width: 140, height: 101)
        secondElement.frame = CGRect(x: secondElementBasePositionX, y: 53, width: 76, height: 76)
        thirdElement.frame = CGRect(x: thirdElementBasePositionX, y: 19, width: 115, height: 185)
    }
    
    @objc private func  onPan(_ gesture: UIPanGestureRecognizer) {
        owner?.changeFlag()
        switch gesture.state {
        case  .ended:
            returnToBasePosition()
        case .changed:
            if firstElement.frame.origin.x >= (contentView.frame.width * 0.29) {
                firstElement.frame.origin.x -= 0.35
                secondElement.frame.origin.x -= 0.5
                scalingSecondElement()
            }
        default:
            break
        }
    }
    
    private func scalingSecondElement() {
        UIView.animate(withDuration: 0.5) {
            self.secondElement.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    private func returnToBasePosition() {
        UIView.animate(withDuration: 0.3) {
            self.firstElement.frame.origin.x = self.firstElementBasePositionX
            self.secondElement.frame.origin.x = self.secondElementBasePositionX
            self.thirdElement.frame.origin.x = self.thirdElementBasePositionX
            self.secondElement.transform = CGAffineTransform.identity
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

