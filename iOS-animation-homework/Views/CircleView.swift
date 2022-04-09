//
//  CircleView.swift
//  iOS-animation-homework
//
//  Created by Руслан on 08.04.2022.
//

import UIKit

class CircleView: UIView {
    // MARK: UI components
    
    lazy var circleLayer: CAShapeLayer = {
        let arcCenter = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let circlePath = UIBezierPath(arcCenter: arcCenter,
                                      radius: arcCenter.x,
                                      startAngle: -.pi / 2,
                                      endAngle: 3 * .pi / 2,
                                      clockwise: true)
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.green.cgColor
        circleLayer.lineWidth = 10
        circleLayer.strokeEnd = 0
        return circleLayer
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.addSublayer(circleLayer)
        configureColorAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Animations
    
    func configureColorAnimation() {
        let animation = CABasicAnimation(keyPath: "strokeColor")
        animation.duration = 5
        animation.fromValue = UIColor.red.cgColor
        animation.toValue = UIColor.green.cgColor
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        circleLayer.add(animation, forKey: "strokeColor")
    }
}
