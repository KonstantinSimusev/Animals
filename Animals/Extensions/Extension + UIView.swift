//
//  Extension + UIView.swift
//  Animals
//
//  Created by Konstantin Simusev on 30.06.2022.
//

import UIKit

// MARK: - Set background color
extension UIView {
    func addVerticalGradientLayr(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}
