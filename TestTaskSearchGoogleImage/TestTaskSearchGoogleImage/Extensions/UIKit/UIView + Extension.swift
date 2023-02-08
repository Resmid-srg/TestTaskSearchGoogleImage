//
//  UIView + Extension.swift
//  TestTaskSearchGoogleImage
//
//  Created by Serov Dmitry on 08.02.23.
//

import UIKit

extension UIView {
    
    //MARK: - activityIndicatorView animation
    
    func activityStartAnimating(color: UIColor = .white) {
        let backgroundView = UIView()
        backgroundView.frame = CGRect.init(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 140)
        backgroundView.tag = 475647
        
        var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
        activityIndicator = UIActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.center = self.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = color
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        
        backgroundView.addSubview(activityIndicator)
        
        self.addSubview(backgroundView)
    }
    
    func activityStopAnimating() {
        if let background = viewWithTag(475647) {
            background.removeFromSuperview()
        }
    }
}
