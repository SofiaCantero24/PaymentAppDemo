//
//  SuccessViewController.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit
import Lottie

class SuccessViewController: BaseViewController {
    @IBOutlet weak var animationView: AnimationView! {
        didSet {
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .playOnce
            animationView.animationSpeed = 1
        }
    }

    @IBOutlet weak var successLabel: UILabel! {
        didSet {
            successLabel.text = Localizables.successTitle
            successLabel.textColor = .darkGray
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animationView.play()
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
