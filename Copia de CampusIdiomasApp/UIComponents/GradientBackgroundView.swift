//
//  GradientBackgroundView.swift
//  CampusIdiomasApp
//
//  Created by MacBook Pro Touch on 20/12/25.
//

import UIKit

final class GradientBackgroundView: UIView {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 138/255, green: 1/255, blue: 141/255, alpha: 1.0).cgColor, // #8A018D
            UIColor(red: 214/255, green: 5/255, blue: 218/255, alpha: 1.0).cgColor  // #D605DA
        ]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }
}


