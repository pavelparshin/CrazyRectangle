//
//  AnimationModel.swift
//  CrazyRectangle
//
//  Created by Pavel Parshin on 16.06.2020.
//  Copyright © 2020 Pavel Parshin. All rights reserved.
//

struct AnimationModel {
    var animation: String
    
    var nextAnimation: String {
        getNextAnimation(animation: animation)
    }
    
    var curve: String
    var delay: Float
    var duration: Float
    var velocity: Float
    var repeatCount: Float
    
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
    
    static func setDefault() -> AnimationModel {
        let animation = AnimationDataManager.shared.animations.first!
        
        return AnimationModel(animation: animation,
                              curve: AnimationDataManager.shared.curves.first!,
                              delay: 0,
                              duration: 0.8,
                              velocity: 0.7,
                              repeatCount: 1)
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
