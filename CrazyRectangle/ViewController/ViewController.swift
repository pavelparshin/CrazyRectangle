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
    
    //MARK: - Pravate propertys
    private let animationData = AnimationDataManager.shared
    private var animationModel = AnimationModel.setDefault()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showPropertys()
    }
    
    //MARK: IB Action
    @IBAction func actionButton(_ sender: SpringButton) {
        let action = animationModel.animation
        let curve = animationModel.curve
        
        showPropertys()
        
        setOptions(action: action, curve: curve)
        rectActionView.animate()
        
        nextAnimation()
    }
    
    //MARK: - Private methods
    
    //Setup properties for Spring animation
    private func setOptions(action: String, curve: String) {
        rectActionView.animation = action
        rectActionView.curve = curve
        rectActionView.delay = CGFloat(animationModel.delay)
        rectActionView.duration = CGFloat(animationModel.duration)
        rectActionView.velocity = CGFloat(animationModel.velocity)
        rectActionView.repeatCount = animationModel.repeatCount
        rectActionView.rotate = CGFloat(animationModel.rotate)
        rectActionView.opacity = CGFloat(animationModel.opacity)
    }
    
    private func showPropertys() {
        descriptionLabel.text = """
        animation: \(animationModel.animation)
        curve: \(animationModel.curve)
        """
        
        buttonSetting.setTitle("\(animationModel.animation)", for: .normal)
    }
    
    private func nextAnimation() {
        //get index for current animation
        let indexAnimation = animationData.animations.firstIndex(of: animationModel.animation) ?? 0
        if indexAnimation < (animationData.animations.count - 1) {
            animationModel.animation = animationData.animations[indexAnimation + 1]
        } else {
            animationModel.animation = animationData.animations.first!
        }
        
        buttonSetting.setTitle("next: \(animationModel.animation)", for: .normal)
        
    }
}

