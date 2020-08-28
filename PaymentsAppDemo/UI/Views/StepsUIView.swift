//
//  StepsUIView.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

enum AnimationType {
    case forward
    case backward
}

class StepsUIView: UIView {
    @IBOutlet weak var firstViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var thirdViewWidthConstraint: NSLayoutConstraint!
    
    func setupView(with step: PaymentsSteps, and type: AnimationType) {
        layoutIfNeeded()
        let constraint = getStepWidthConstraint(step)
        UIView.animate(withDuration: 0.5) {
            switch type {
            case .backward:
                constraint.constant = 0
            case .forward:
                constraint.constant = self.firstViewWidthConstraint.constant
            }
        }
    }

    private func getStepWidthConstraint(_ step: PaymentsSteps) -> NSLayoutConstraint {
        switch step {
        case .paymentMethods:
            return firstViewWidthConstraint
        case .cardIssuers:
            return secondViewWidthConstraint
        case .installments:
            return thirdViewWidthConstraint
        }
    }
}
