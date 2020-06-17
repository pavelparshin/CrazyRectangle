//
//  MainViewController.swift
//  CrazyRectangle
//
//  Created by Pavel Parshin on 16.06.2020.
//  Copyright © 2020 Pavel Parshin. All rights reserved.
//

import Spring

class MainViewController: UIViewController {
    
    //MARK: - IB Outlet
    @IBOutlet var rectActionView: SpringView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var buttonSetting: SpringButton!
    @IBOutlet var isRandom: UISwitch!
    @IBOutlet var selectCurveButton: UIButton!
    @IBOutlet var curveStackView: UIStackView!
    
    //MARK: - Pravate propertys
    private let animationData = AnimationDataManager.shared
    private var animationModel = AnimationModel()
    
    private var randomAnimation: AnimationModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        randomAnimation = animationModel
        showProperties()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animationModel.curve = animationData.selectCurve
        showProperties()
    }
    
    //MARK: IB Action
    @IBAction func randomSwitchAction() {
        curveStackView.isHidden = isRandom.isOn
        animationModel.isRandom = isRandom.isOn
        actionButton(buttonSetting)
    }
    
    @IBAction func actionButton(_ sender: SpringButton) {
        let action = animationModel.animation
        let selectCurve = animationData.selectCurve

        setOptions(action: action, curve: selectCurve, buttonTag: sender.tag)
        
        rectActionView.animate()
        
        nextAnimation(buttonTag: sender.tag)
        showProperties()
    }
    
    @IBAction func unwindToCurve(_ unwindSegue: UIStoryboardSegue) {
    }
    
    //MARK: - Private methods
    
    //Setup properties for Spring animation
    private func setOptions(action: String, curve: String, buttonTag: Int) {
    
        if isRandom.isOn {
            
            if buttonTag == 0 {
                animationModel = randomAnimation
            }
            
            rectActionView.animation = animationModel.animation
            rectActionView.curve = animationModel.curve
            rectActionView.delay = CGFloat(animationModel.delay)
            rectActionView.duration = CGFloat(animationModel.duration)
            rectActionView.velocity = CGFloat(animationModel.velocity)
            rectActionView.repeatCount = animationModel.repeatCount
            
            AnimationDataManager.shared.selectCurve = animationModel.curve
            
        } else {
            
            animationModel.isRandom = false
            if buttonTag == 0 {
                rectActionView.animation = animationModel.nextAnimation
            } else {
                rectActionView.animation = action
            }
            
            rectActionView.curve = curve
            
        }
    }
    
    private func showProperties() {

        descriptionLabel.text = isRandom.isOn ?
            animationModel.fullDescription : animationModel.shortDescription
        
        selectCurveButton.setTitle(animationModel.curve, for: .normal)
        buttonSetting.setTitle("next: \(animationModel.nextAnimation)", for: .normal)
    }

    private func nextAnimation(buttonTag: Int) {
        if buttonTag == 0 {
            animationModel.animation = animationModel.nextAnimation
            if isRandom.isOn {
                randomAnimation = AnimationModel()
                randomAnimation.setRandomAnimation()
                animationModel.nextRandomAnimation = randomAnimation.animation
            }
        }

        showProperties()
    }
}

