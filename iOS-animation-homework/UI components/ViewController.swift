//
//  ViewController.swift
//  iOS-animation-homework
//
//  Created by Руслан on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
    }
    
    private func addSubviews() {
        let circleWidth: CGFloat = 200
        let circleHeight = circleWidth
        let circleX = (view.frame.width - circleWidth) / 2
        let circleY = (view.frame.height - circleHeight) / 2
        
        let circleView = CircleView(frame: CGRect(x: circleX, y: circleY, width: circleWidth, height: circleHeight))
        
        view.addSubview(circleView)
        
        circleView.animateCircle(duration: 1.0)
    }
}
