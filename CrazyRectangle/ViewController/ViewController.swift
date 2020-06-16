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
    
    //MARK: - Pravate propertys
    private let animationData = AnimationDataManager.shared
    private var animationModel = AnimationModel.setDefault()
    
    private var randomAnimation: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showPropertys()
    }
    
    //MARK: IB Action
    @IBAction func actionButton(_ sender: SpringButton) {
        let action = animationModel.animation
        let curve = animationModel.curve
        
        if isRandom.isOn {
            setRandomOptions()
        } else {
            setOptions(action: action, curve: curve)
        }
        
        showPropertys()
        
        rectActionView.animate()
        
        nextAnimation()
    }
    
    //MARK: - Private methods
    
    //Setup properties for Spring animation
    private func setOptions(action: String, curve: String) {
        rectActionView.animation = action
        rectActionView.curve = curve
    }
    
    private func setRandomOptions() {
        rectActionView.animation = randomAnimation ?? animationData.animations.first!
        rectActionView.curve = animationData.curves.randomElement() ?? ""
        rectActionView.delay = CGFloat.random(in: 0...0.5)
        rectActionView.duration = CGFloat.random(in: 0.5...1.5)
        rectActionView.velocity = CGFloat.random(in: 0.2...0.9)
        rectActionView.repeatCount = Float.random(in: 1...3)
        
        randomAnimation = animationData.animations.randomElement()!
        print(rectActionView.delay)
    }
    
    private func showPropertys() {
        
        if isRandom.isOn {
            descriptionLabel.text = """
            animation: \(animationModel.animation)
            curve: \(animationModel.curve)
            delay: \(animationModel.delay)
            duration: \(animationModel.duration)
            velocity: \(animationModel.velocity)
            repeatCount: \(animationModel.repeatCount)
            """
        } else {
            descriptionLabel.text = """
            animation: \(animationModel.animation)
            curve: \(animationModel.curve)
            """
        }
        
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

