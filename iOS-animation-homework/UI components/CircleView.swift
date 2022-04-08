//
//  CircleView.swift
//  iOS-animation-homework
//
//  Created by Руслан on 08.04.2022.
//

import UIKit

class CircleView: UIView {
    var circleLayer: CAShapeLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addCirclePath()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addCirclePath() {
        let arcCenter = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let circlePath = UIBezierPath(arcCenter: arcCenter,
                                      radius: arcCenter.x,
                                      startAngle: -.pi / 2,
                                      endAngle: .pi * 2,
                                      clockwise: true)
        
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 5
        
        circleLayer.strokeEnd = 0
        
        layer.addSublayer(circleLayer)
    }
    
    func animateCircle(duration: TimeInterval) {
        let animation = CABasicAnimation(keyPath: #keyPath(CAShapeLayer.strokeEnd))

        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = 1

        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)

        circleLayer.strokeEnd = 1.0
        circleLayer.add(animation, forKey: "animateCircle")
    }
}
