//
//  UIImageView + Extension.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 08.02.23.
//

import UIKit

extension UIImageView {

    // Animation Push from left to right
    func pushUpTransitionRight(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }

    // Animation Push from right to left
    func pushUpTransitionLeft(_ duration: CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.push
        animation.subtype = CATransitionSubtype.fromRight
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}
