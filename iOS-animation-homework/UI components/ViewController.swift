//
//  ViewController.swift
//  iOS-animation-homework
//
//  Created by Руслан on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {
    private lazy var circleView: CircleView = {
        let width: CGFloat = 200
        let height = width
        let x = (view.frame.width - width) / 2
        let y = (view.frame.height - height) / 2
        
        return CircleView(frame: CGRect(x: x, y: y, width: width, height: height))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(circleView)
        
        circleView.animateCircle(duration: 3.0)
    }
}
