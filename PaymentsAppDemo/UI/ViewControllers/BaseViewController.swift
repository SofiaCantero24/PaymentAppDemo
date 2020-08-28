//
//  BaseViewController.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/27/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    lazy var presentationManager = AlertSlidePresentationManager()

    func showAlertMessage(title: String, message: String) {
        let alertViewModel = AlertViewModel(title: title,
                                            message: message)
        let alertViewController = AlertViewController(viewModel: alertViewModel)
        alertViewController.transitioningDelegate = presentationManager
        alertViewController.modalPresentationStyle = .custom
        
        present(alertViewController, animated: true, completion: nil)
    }
}
