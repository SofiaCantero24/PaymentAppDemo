//
//  AlertViewController.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class AlertViewController: UIViewController {
    @IBOutlet weak private var alertView: UIView! {
        didSet {
            alertView.clipsToBounds = true
            alertView.layer.cornerRadius = 10
            alertView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }

    @IBOutlet weak private var alertTitleLabel: UILabel! {
        didSet {
            alertTitleLabel.text = viewModel.title
        }
    }

    @IBOutlet weak private var alertMessageLabel: UILabel! {
        didSet {
            alertMessageLabel.text = viewModel.message
        }
    }

    let viewModel: AlertViewModel

    init(viewModel: AlertViewModel) {
        self.viewModel = viewModel
        super.init(nibName: AlertViewController.className, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
