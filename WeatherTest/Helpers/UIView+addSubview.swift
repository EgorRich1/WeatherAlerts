//
//  UIView+addSubview.swift
//  WeatherTest
//
//  Created by Егор Ярошук on 13.01.24.
//

import UIKit

extension UIView {
    func addSubview(_ subview: UIView, activate: [NSLayoutConstraint]) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(activate)
    }
}
