//
//  SlidePresentationManager.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/25/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

final class AlertSlidePresentationManager: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return AlertSlidePresentationController(presentedViewController: presented, presenting: presenting)
    }
}
