//
//  InitialViewController.swift
//  iOS-animation-homework
//
//  Created by Руслан on 08.04.2022.
//

import UIKit

final class InitialViewController: UIViewController {
    // MARK: UI components
    
    @IBOutlet var flagsImageViews: [UIImageView]!
    
    // MARK: Properties
    
    var selectedImageView: UIImageView?
    private var selectedImageViewSnapshot: UIView?
    
    var animator: Animator?
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        flagsImageViews.forEach { flagImageView in
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapFlagImageView))
            flagImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    // MARK: Actions
    
    @objc private func didTapFlagImageView(sender: UITapGestureRecognizer) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController")
        guard let viewController = viewController as? ViewController else { return }
        
        selectedImageView = sender.view as? UIImageView
        selectedImageViewSnapshot = selectedImageView?.snapshotView(afterScreenUpdates: false)
        
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .fullScreen
        viewController.flagImage = selectedImageView?.image
        
        present(viewController, animated: true)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension InitialViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let presenting = presenting as? InitialViewController,
              let presented = presented as? ViewController,
              let selectedImageViewSnapshot = selectedImageViewSnapshot else {
                  return nil
              }
        animator = Animator(type: .present,
                            from: presenting,
                            to: presented,
                            selectedImageViewSnapshot: selectedImageViewSnapshot)
        return animator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard let dismissed = dismissed as? ViewController,
              let selectedImageViewSnapshot = selectedImageViewSnapshot else {
                  return nil
              }
        animator = Animator(type: .dismiss,
                            from: self,
                            to: dismissed,
                            selectedImageViewSnapshot: selectedImageViewSnapshot)
        return animator
    }
}
