//
//  ViewController.swift
//  iOS-animation-homework
//
//  Created by Руслан on 08.04.2022.
//

import UIKit

class ViewController: UIViewController {
    // MARK: UI components
    
    private lazy var numberLabel: UILabel = {
        let width: CGFloat = 100, height: CGFloat = 50
        let x = view.center.x - width / 2, y = view.center.y - height / 2
        let label = UILabel(frame: CGRect(x: x, y: y, width: width, height: height))
        
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.text = "0"
        
        return label
    }()
    
    private lazy var circleView: CircleView = {
        let width: CGFloat = 200
        let height = width
        let x = (view.frame.width - width) / 2
        let y = (view.frame.height - height) / 2
        
        return CircleView(frame: CGRect(x: x, y: y, width: width, height: height))
    }()
    
    // MARK: Properties
    
    private var animator: UIViewPropertyAnimator!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(circleView)
        view.addSubview(numberLabel)
        configureAnimator()
        startNumberLoading()
    }
    
    // MARK: Animations
    
    private func configureAnimator() {
        let newPoint = CGPoint(x: self.view.center.x, y: self.view.center.y / 2)
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
            self.circleView.center = newPoint
            self.numberLabel.center = newPoint
        })
    }
    
    private func animateCircleViewScaling() {
        UIView.animate(withDuration: 1) {
            self.circleView.transform = .init(scaleX: 10, y: 10)
        }
    }
    
    private func startNumberLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
            let value = Int(self?.numberLabel.text ?? "0") ?? 0
            let nextValue = value + 1
            
            self?.numberLabel.text = String(nextValue)
            self?.circleView.circleLayer.strokeEnd = CGFloat(nextValue) / 100
            self?.animator.fractionComplete = CGFloat(nextValue) / 100
            
            if nextValue == 100 {
                timer.invalidate()
                self?.animateCircleViewScaling()
            }
        }
    }
}
