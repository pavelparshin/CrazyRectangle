//
//  AnimationModel.swift
//  CrazyRectangle
//
//  Created by Pavel Parshin on 16.06.2020.
//  Copyright © 2020 Pavel Parshin. All rights reserved.
//

struct AnimationModel {
    var animation: String
    var curve: String
    var delay: Float
    var duration: Float
    var velocity: Float
    var repeatCount: Float
    
    static func setDefault() -> AnimationModel {
        return AnimationModel(animation: AnimationDataManager.shared.animations.first ?? "",
                              curve: AnimationDataManager.shared.curves.first ?? "",
                              delay: 0,
                              duration: 0.7,
                              velocity: 0.7,
                              repeatCount: 1)
    }
}
