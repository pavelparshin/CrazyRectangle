//
//  AnimationModel.swift
//  CrazyRectangle
//
//  Created by Pavel Parshin on 16.06.2020.
//  Copyright © 2020 Pavel Parshin. All rights reserved.
//

struct AnimationModel {
    var animation = AnimationDataManager.shared.animations.first!
    
    var nextAnimation: String {
        if isRandom {
            return nextRandomAnimation ?? animation
        } else {
            return getNextAnimation(animation: animation)
        }
    }
    
    var nextRandomAnimation: String?
    var isRandom = false
    
    var curve = AnimationDataManager.shared.curves.first!
    var delay: Float = 0
    var duration: Float = 0.8
    var velocity: Float = 0.7
    var repeatCount: Float = 1
    
    var shortDescription: String {
        """
        animation: \(animation)
        curve: \(curve)
        """
    }
    
    var fullDescription: String {
        """
        animation: \(animation)
        curve: \(curve)
        delay: \(string(delay))
        duration: \(string(duration))
        velocity: \(string(velocity))
        repeatCount: \(string(repeatCount))
        """
    }
    
    mutating func setRandomAnimation() {
        animation = AnimationDataManager.shared.animations.randomElement()!
        curve = AnimationDataManager.shared.curves.randomElement()!
        nextRandomAnimation = animation
        isRandom = true
        delay = Float.random(in: 0...0.5)
        duration = Float.random(in: 0.5...1.5)
        velocity = Float.random(in: 0.2...0.9)
        repeatCount = Float.random(in: 1...3)
    }
    
    private func string(_ number: Float) -> String {
        return String(format: "%.2f", number)
    }
    
    func getNextAnimation(animation: String) -> String {
        let animations = AnimationDataManager.shared.animations
        let currentIndexAnimation = animations.firstIndex(of: animation) ?? 0
        var nextIndexAnimation = currentIndexAnimation + 1
        if nextIndexAnimation >= animations.count {
            nextIndexAnimation = 0
        }
        
        return animations[nextIndexAnimation]
    }
}
