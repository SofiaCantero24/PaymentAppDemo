//
//  AlertSlidePresentationController.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/25/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class AlertSlidePresentationController: UIPresentationController {
    private lazy var dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.alpha = 0.0
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
        return dimmingView
    }()

    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            guard let theView = containerView else { return CGRect.zero }
            return CGRect(x: 0,
                          y: theView.bounds.height - theView.bounds.height/4,
                          width: theView.bounds.width,
                          height: theView.bounds.height/4)
        }
    }

    override func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)
        dimmingView.frame = containerView?.bounds ?? .zero
        setDimmingAlpha(1.0)
    }

    override func dismissalTransitionWillBegin() {
        setDimmingAlpha(0.0)
    }

    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    // MARK: - Private Methods
    @objc
    private func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }

    private func setDimmingAlpha(_ alpha: CGFloat) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
          dimmingView.alpha = alpha
          return
        }

        coordinator.animate(alongsideTransition: { _ in
          self.dimmingView.alpha = alpha
        })
    }
}
