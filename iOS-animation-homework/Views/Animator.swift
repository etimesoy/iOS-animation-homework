//
//  Animator.swift
//  iOS-animation-homework
//
//  Created by Руслан on 08.04.2022.
//

import UIKit

final class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    static let duration: TimeInterval = 1.25
    
    private let type: PresentationType
    private let fromViewController: InitialViewController
    private let toViewController: ViewController
    private var selectedImageViewSnapshot: UIView
    private let imageViewRect: CGRect
    
    init?(
        type: PresentationType,
        from fromViewController: InitialViewController,
        to toViewController: ViewController,
        selectedImageViewSnapshot: UIView
    ) {
        self.type = type
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        self.selectedImageViewSnapshot = selectedImageViewSnapshot
        
        guard let window = fromViewController.view.window ?? toViewController.view.window,
              let selectedImageView = fromViewController.selectedImageView else {
                  return nil
              }
        imageViewRect = selectedImageView.convert(selectedImageView.bounds, to: window)
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let isPresenting = type.isPresenting
        guard let toView = toViewController.view else {
            return transitionContext.completeTransition(false)
        }
        containerView.addSubview(toView)
        
        guard let selectedImageView = fromViewController.selectedImageView,
              let window = fromViewController.view.window ?? toViewController.view.window,
              let flagImageSnapshot = selectedImageView.snapshotView(afterScreenUpdates: true),
              let controllerImageSnapshot = toViewController.flagImageView.snapshotView(afterScreenUpdates: true),
              let crossImageViewSnapshot = toViewController.crossImageView.snapshotView(afterScreenUpdates: true) else {
                  return transitionContext.completeTransition(true)
              }
        
        let backgroundView: UIView
        let fadeView = UIView(frame: containerView.bounds)
        fadeView.backgroundColor = toViewController.view.backgroundColor
        if isPresenting {
            selectedImageView.isHidden = true
        }
        
        if isPresenting {
            selectedImageViewSnapshot = flagImageSnapshot
            
            backgroundView = UIView(frame: containerView.bounds)
            backgroundView.addSubview(fadeView)
            fadeView.alpha = 0
        } else {
            backgroundView = fromViewController.view.snapshotView(afterScreenUpdates: true) ?? fadeView
            backgroundView.addSubview(fadeView)
        }
        
        toView.alpha = 0
        
        [backgroundView, selectedImageViewSnapshot, controllerImageSnapshot, crossImageViewSnapshot].forEach {
            containerView.addSubview($0)
        }
        
        let controllerImageViewRect = toViewController.flagImageView.convert(toViewController.flagImageView.bounds,
                                                                             to: window)
        let crossImageViewRect = toViewController.crossImageView.convert(toViewController.crossImageView.bounds,
                                                                         to: window)
        [selectedImageViewSnapshot, controllerImageSnapshot].forEach {
            $0.frame = isPresenting ? imageViewRect : controllerImageViewRect
        }
        crossImageViewSnapshot.frame = crossImageViewRect
        
        controllerImageSnapshot.alpha = isPresenting ? 0 : 1
        selectedImageViewSnapshot.alpha = isPresenting ? 1 : 0
        crossImageViewSnapshot.alpha = isPresenting ? 0 : 1
        
        UIView.animateKeyframes(withDuration: Self.duration, delay: 0, options: .calculationModeCubic) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1) {
                self.selectedImageViewSnapshot.frame = isPresenting ? controllerImageViewRect : self.imageViewRect
                controllerImageSnapshot.frame = isPresenting ? controllerImageViewRect : self.imageViewRect
                fadeView.alpha = isPresenting ? 1 : 0
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.6) {
                self.selectedImageViewSnapshot.alpha = isPresenting ? 0 : 1
                controllerImageSnapshot.alpha = isPresenting ? 1 : 0
            }
            UIView.addKeyframe(withRelativeStartTime: isPresenting ? 0.7 : 0, relativeDuration: 0.3) {
                crossImageViewSnapshot.alpha = isPresenting ? 1 : 0
            }
        } completion: { _ in
            self.selectedImageViewSnapshot.removeFromSuperview()
            controllerImageSnapshot.removeFromSuperview()
            backgroundView.removeFromSuperview()
            crossImageViewSnapshot.removeFromSuperview()
            
            toView.alpha = 1
            transitionContext.completeTransition(true)
            if !isPresenting {
                selectedImageView.isHidden = false
            }
        }
    }
}

enum PresentationType {
    case present
    case dismiss
    
    var isPresenting: Bool {
        return self == .present
    }
}
