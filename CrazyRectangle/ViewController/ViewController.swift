//
//  ViewController.swift
//  CrazyRectangle
//
//  Created by Pavel Parshin on 16.06.2020.
//  Copyright © 2020 Pavel Parshin. All rights reserved.
//

import Spring

class ViewController: UIViewController {
    
    //MARK: - IB Outlet
    @IBOutlet var rectActionView: SpringView!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var buttonSetting: SpringButton!
    @IBOutlet var isRandom: UISwitch!
    @IBOutlet var currentCurveLabel: UILabel!
    @IBOutlet var selectCurveButton: UIButton!
    @IBOutlet var curveStackView: UIStackView!
    
    //MARK: - Pravate propertys
    private let animationData = AnimationDataManager.shared
    private var animationModel = AnimationModel.setDefault()
    
    private var randomAnimation: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showProperties()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animationModel.curve = AnimationDataManager.shared.selectCurve
        showProperties()
    }
    
    //MARK: IB Action
    @IBAction func randomSwitchAction() {
        curveStackView.isHidden = isRandom.isOn
    }
    
    @IBAction func actionButton(_ sender: SpringButton) {
        let action = animationModel.animation
        let selectCurve = AnimationDataManager.shared.selectCurve
        
        setOptions(action: action, curve: selectCurve)
        
        showProperties()
        rectActionView.animate()
        
        if sender.tag == 0 {
            nextAnimation()
        }
    }
    
    @IBAction func unwindToCurve(_ unwindSegue: UIStoryboardSegue) {
    }
    
    //MARK: - Private methods
    
    //Setup properties for Spring animation
    private func setOptions(action: String, curve: String) {
        
        rectActionView.animation = action
        rectActionView.curve = curve
        
        if isRandom.isOn {
            
            getRandomAnimation()
            
            rectActionView.animation = animationModel.animation
            rectActionView.curve = animationModel.curve
            rectActionView.delay = CGFloat(animationModel.delay)
            rectActionView.duration = CGFloat(animationModel.duration)
            rectActionView.velocity = CGFloat(animationModel.velocity)
            rectActionView.repeatCount = animationModel.repeatCount
            
            randomAnimation = animationData.animations.randomElement()!
        
        }
    }
    
    private func getRandomAnimation() {
        
        let animation = randomAnimation ?? animationData.animations.first!
        let curve = animationData.curves.randomElement() ?? ""
        let delay = Float.random(in: 0...0.5)
        let duration = Float.random(in: 0.5...1.5)
        let velocity = Float.random(in: 0.2...0.9)
        let repeatCount = Float.random(in: 1...3)
        
        animationModel = AnimationModel(animation: animation,
                                        curve: curve,
                                        delay: delay,
                                        duration: duration,
                                        velocity: velocity,
                                        repeatCount: repeatCount)
    }
    
    private func showProperties() {

        descriptionLabel.text = isRandom.isOn ?
            animationModel.fullDescription : animationModel.shortDescription
        
        selectCurveButton.setTitle(animationModel.curve, for: .normal)
        buttonSetting.setTitle("\(animationModel.animation)", for: .normal)
    }
    
    private func nextAnimation() {
        if isRandom.isOn {
            animationModel.animation = randomAnimation
        } else {
            
            //get index for current animation
            let indexAnimation = animationData.animations.firstIndex(of: animationModel.animation) ?? 0
            
            if indexAnimation < (animationData.animations.count - 1) {
                animationModel.animation = animationData.animations[indexAnimation + 1]
            } else {
                animationModel.animation = animationData.animations.first!
            }
        }
    
        buttonSetting.setTitle("next: \(animationModel.animation)", for: .normal)
    }
    
}

