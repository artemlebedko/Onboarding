//
//  OnboardingViewController.swift
//  Onboarding
//
//  Created by Artem on 23/09/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

import UIKit

protocol OnboardingBaseCellOwner: class {
    func changeFlag()
}

class OnboardingViewController: UIViewController, OnboardingViewInput {
    
    @IBOutlet weak var pageControl: PillPageControl!
    @IBOutlet weak var blueBubble: GradientView!
    @IBOutlet weak var greenBubble: GradientView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet weak var stackViewWithCollectionView: UIStackView!
    @IBOutlet weak var stackViewWithButtons: UIStackView!
    @IBOutlet weak var spaceBetweenStacks: NSLayoutConstraint!
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        userInteractionWithCellsFlag = true
        let visibleItems: NSArray = self.collectionView.indexPathsForVisibleItems as NSArray
        let currentItem: IndexPath = visibleItems.object(at: 0) as! IndexPath
        let nextItem: IndexPath = IndexPath(item: currentItem.item + 1, section: 0)
        if nextItem.row < 3 {
            self.collectionView.scrollToItem(at: nextItem, at: .left, animated: true)
        }
        if collectionView.cellForItem(at: IndexPath(row: 2, section: 0)) != nil {
            output.openTabBar(navigationController: navigationController)
        }
    }
    
    @IBAction func skipButtonPressed(_ sender: UIButton) {
        output.openTabBar(navigationController: navigationController)
    }
    
    var output: OnboardingViewOutput!
    var timer = Timer()
    var visibleCellCount = 1
    var userInteractionWithCellsFlag = false
    var nextButtonBasePosition: CGFloat = 0
    var skipBittonBasePosition: CGFloat = 0
    let minPageControlState: CGFloat    = -10.0
    let maxPageControlState: CGFloat    = 10.0
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupBubbles()
        calculateSpacing()
        calculateButtonBasePositions()
    }
    
    private func setupUI() {
        navigationController?.navigationBar.isHidden = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        registerCells()
        startTimer()
        nextButton.layer.cornerRadius = 8.0
        nextButton.drawShadow(color: ColorScheme.shared.brandOrange, radius: 15.0, opacity: 0.35)
    }
    
    private func registerCells() {
        collectionView.register(UINib(nibName: "OnboardingCellHouse", bundle: nil), forCellWithReuseIdentifier: "OnboardingCellHouse")
        collectionView.register(UINib(nibName: "OnboardingCellCar", bundle: nil), forCellWithReuseIdentifier: "OnboardingCellCar")
        collectionView.register(UINib(nibName: "OnboardingCellPhone", bundle: nil), forCellWithReuseIdentifier: "OnboardingCellPhone")
    }
    
    private func calculateButtonBasePositions() {
        nextButtonBasePosition = nextButton.frame.origin.y
        skipBittonBasePosition = skipButton.frame.origin.y
    }
    
    private func calculateSpacing() {
        if UIDevice.current.screenSize == .small {
            stackViewWithCollectionView.spacing = 10.0
            spaceBetweenStacks.constant = 15.0
        } else {
            stackViewWithCollectionView.spacing = 40.0
            spaceBetweenStacks.constant = 30.0
        }
    }
    
    // MARK: OnboardingViewInput
    func setupInitialState() {
    }
    
    private func setupBubbles() {
        blueBubble.frame.size = CGSize(width: 241 * view.frame.width / 375, height: 241 * view.frame.width / 375)
        blueBubble.layer.cornerRadius = blueBubble.frame.height / 2
        blueBubble.frame.origin = CGPoint(x: view.frame.width - blueBubble.frame.width + 19, y: -100)
        greenBubble.frame.size = CGSize(width: 114 * view.frame.width / 375, height: 114 * view.frame.width / 375)
        greenBubble.layer.cornerRadius = greenBubble.frame.height / 2
        greenBubble.frame.origin = CGPoint(x: view.frame.width - (greenBubble.frame.width * 0.44), y: view.frame.height / 2)
        greenBubble.alpha = 0.0
        baseBubblesPosition()
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCellHouse", for: indexPath) as! OnboardingBaseCell
            cell.owner = self
            return cell
        } else if indexPath.row == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCellCar", for: indexPath) as! OnboardingCellCar
            cell.owner = self
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCellPhone", for: indexPath) as! OnboardingCellPhone
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 208.0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let page = scrollView.contentOffset.x / scrollView.bounds.width
        let progressInPage = scrollView.contentOffset.x - (page * scrollView.bounds.width)
        let progress = CGFloat(page) + progressInPage
        pageControl.progress = progress
        updateButtons()
        
        switch pageControl.progress {
        case minPageControlState...0.33:
            baseBubblesPosition()
        case 0.34...1.33:
            moveBlueBubble()
        case 1.34...maxPageControlState:
            moveGreenBubble()
        default:
            break
        }
    }
}

extension OnboardingViewController: OnboardingBaseCellOwner {
    func changeFlag() {
        userInteractionWithCellsFlag = true
    }
    
    private func updateButtons() {
        switch pageControl.progress {
        case minPageControlState...1.49:
            showSkipButton()
        case 1.5...maxPageControlState:
            hideSkipButton()
        default:
            break
        }
    }
    
    private func hideSkipButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.nextButton.backgroundColor = ColorScheme.shared.green
            self.nextButton.drawShadow(color: ColorScheme.shared.green, radius: 15.0, opacity: 0.35)
            self.nextButton.frame.origin.y = self.skipBittonBasePosition
        }) { (action) in
            self.skipButton.frame.origin.y += 50
            self.skipButton.alpha = 0.0
        }
    }
    
    private func showSkipButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.nextButton.backgroundColor = ColorScheme.shared.brandOrange
            self.nextButton.drawShadow(color: ColorScheme.shared.brandOrange, radius: 15.0, opacity: 0.35)
            self.nextButton.frame.origin.y = self.nextButtonBasePosition
        }) { (action) in
            UIView.animate(withDuration: 0.5, animations: {
                self.skipButton.frame.origin.y = self.skipBittonBasePosition
                self.skipButton.alpha = 1.0
            })
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextCellOnTimer), userInfo: nil, repeats: true);
    }
    
    private func stopTimer() {
        timer.invalidate()
    }
    
    @objc private func scrollToNextCellOnTimer() {
        if !userInteractionWithCellsFlag {
            if self.visibleCellCount < 3 {
                let indexPath = IndexPath(item: visibleCellCount, section: 0)
                self.collectionView.scrollToItem(at: indexPath, at: .right, animated: true)
                self.visibleCellCount = self.visibleCellCount + 1
            } else {
                userInteractionWithCellsFlag = true
                stopTimer()
            }
        }
    }
    
    private func baseBubblesPosition() {
        UIView.animate(withDuration: 0.3) {
            self.blueBubble.frame.origin.x = self.view.frame.width - (self.blueBubble.frame.width * 0.48)
            self.greenBubble.frame.origin.y = self.view.frame.height / 2
            self.greenBubble.alpha = 0.0
        }
    }
    
    private func moveBlueBubble() {
        UIView.animate(withDuration: 0.3) {
            self.blueBubble.frame.origin.x = self.view.frame.minX - (self.blueBubble.frame.width * 0.49)
            self.greenBubble.frame.origin = CGPoint(x: self.view.frame.width - (self.greenBubble.frame.width * 0.44), y: (self.view.frame.minY + self.greenBubble.frame.height))
            self.greenBubble.transform = CGAffineTransform.identity
            self.greenBubble.alpha = 1.0
            self.greenBubble.frame.size = CGSize(width: 114 * self.view.frame.width / 375, height: 114 * self.view.frame.width / 375)
        }
    }
    
    private func moveGreenBubble() {
        UIView.animate(withDuration: 0.3) {
            self.blueBubble.frame.origin.x = self.view.frame.minX - 400
            self.greenBubble.transform = CGAffineTransform(scaleX: 2.114, y: 2.114)
            self.greenBubble.frame.origin = CGPoint(x: self.view.frame.minX - (self.greenBubble.frame.width * 0.49), y: -100)
        }
    }
}

