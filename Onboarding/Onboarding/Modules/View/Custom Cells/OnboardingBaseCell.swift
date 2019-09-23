//
//  OnboardingBaseCell.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

class OnboardingBaseCell: UICollectionViewCell, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var firstElement: UIImageView!
    @IBOutlet weak var secondElement: UIImageView!
    @IBOutlet weak var thirdElement: UIImageView!
    
    let firstElementBasePositionX: CGFloat   = UIDevice.current.screenSize == .small ? 104.0 : 144.0
    let secondElementBasePositionX: CGFloat  = UIDevice.current.screenSize == .small ? 45.0 : 85.0
    let thirdElementBasePositionX: CGFloat   = UIDevice.current.screenSize == .small ? 146.0 : 186.0
    
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
        self.firstElement.frame = CGRect(x: self.firstElementBasePositionX, y: 84, width: 72, height: 114)
        self.secondElement.frame = CGRect(x: self.secondElementBasePositionX, y: 114, width: 78, height: 82)
        self.thirdElement.frame = CGRect(x: self.thirdElementBasePositionX, y: 24, width: 144, height: 177)
    }
    
    @objc private func onPan(_ gesture: UIPanGestureRecognizer) {
        owner?.changeFlag()
        switch gesture.state {
        case  .ended, .cancelled, .began:
            returnToBasePosition()
        case .changed:
            if firstElement.frame.origin.x <= (contentView.frame.width * 0.44) {
                firstElement.frame.origin.x += 0.5
                secondElement.frame.origin.x += 0.35
                thirdElement.frame.origin.x -= 0.2
            }
        default:
            break
        }
    }
    
    private func returnToBasePosition() {
        UIView.animate(withDuration: 0.3) {
            self.firstElement.frame.origin.x = self.firstElementBasePositionX
            self.secondElement.frame.origin.x = self.secondElementBasePositionX
            self.thirdElement.frame.origin.x = self.thirdElementBasePositionX
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

