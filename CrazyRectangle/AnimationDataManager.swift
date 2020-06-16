//
//  AnimationDataManager.swift
//  CrazyRectangle
//
//  Created by Pavel Parshin on 16.06.2020.
//  Copyright © 2020 Pavel Parshin. All rights reserved.
//

class AnimationDataManager {

    static let shared = AnimationDataManager()

    private init() {
        selectCurve = curves.first!
    }
    
    let animations = ["slideLeft", "slideRight", "slideDown", "slideUp",
                      "squeezeLeft", "squeezeRight", "squeezeDown", "squeezeUp",
                      "fadeIn", "fadeOut", "fadeOutIn", "fadeInLeft",
                      "fadeInRight", "fadeInDown", "fadeInUp", "zoomIn",
                      "zoomOut", "fall", "shake", "pop", "flipX", "flipY",
                      "morph", "squeeze", "flash", "wobble", "swing"]
    
    let curves = ["easeIn", "easeOut", "easeInOut", "linear", "spring",
                  "easeInSine", "easeOutSine", "easeInOutSine", "easeInQuad",
                  "easeOutQuad", "easeInOutQuad", "easeInCubic", "easeOutCubic",
                  "easeInOutCubic", "easeInQuart", "easeOutQuart", "easeInOutQuart",
                  "easeInQuint", "easeOutQuint", "easeInOutQuint", "easeInExpo",
                  "easeOutExpo", "easeInOutExpo", "easeInCirc", "easeOutCirc",
                  "easeInOutCirc", "easeInBack", "easeOutBack", "easeInOutBack"]
    
    var selectCurve: String
    
}
