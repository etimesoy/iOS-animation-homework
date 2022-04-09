//
//  ViewController.swift
//  iOS-animation-homework
//
//  Created by Руслан on 08.04.2022.
//

import UIKit

final class ViewController: UIViewController {
    // MARK: UI components
    
    private lazy var circleView: CircleView = {
        let width: CGFloat = 200
        let height = width
        let x = (view.frame.width - width) / 2
        let y = (view.frame.height - height) / 2

        return CircleView(frame: CGRect(x: x, y: y, width: width, height: height))
    }()
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var crossImageView: UIImageView!
    
    // MARK: Properties
    
    private var animator: UIViewPropertyAnimator!
    var flagImage: UIImage!
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(circleView)
        numberLabel.alpha = 0
        flagImageView.image = flagImage
        
        configureAnimator()
        startNumberLoading()
    }
    
    // MARK: Actions
    
    @IBAction func didTapCrossImageView(_ sender: UITapGestureRecognizer) {
        animator.stopAnimation(true)
        dismiss(animated: true)
    }
    
    // MARK: Animations
    
    private func configureAnimator() {
        let newPoint = CGPoint(x: self.view.center.x, y: self.view.center.y / 2)
        animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear, animations: {
            self.circleView.center = newPoint
            self.numberLabel.center = newPoint
            self.numberLabel.transform = .init(scaleX: 1.25, y: 1.25)
        })
    }
    
    private func animateCircleViewScaling() {
        UIView.animate(withDuration: 1, delay: 0, options: .allowAnimatedContent) {
            self.circleView.transform = .init(scaleX: 10, y: 10)
        } completion: { _ in
            self.circleView.isHidden = true
        }
    }
    
    private func startNumberLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 0.75) {
                self.numberLabel.alpha = 1
            }
            Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [weak self] timer in
                let value = Int(self?.numberLabel.text ?? "0") ?? 0
                let nextValue = value + 1
                
                self?.numberLabel.text = String(nextValue)
                self?.circleView.circleLayer.strokeEnd = CGFloat(nextValue) / 100
                self?.animator.fractionComplete = CGFloat(nextValue) / 100
                
                if nextValue == 100 {
                    timer.invalidate()
                    self?.numberLabel.text = "VPN настроен!"
                    self?.animateCircleViewScaling()
                }
            }
        }
    }
}
