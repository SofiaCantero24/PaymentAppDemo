//
//  SuccessViewController.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit
import Lottie

class SuccessViewController: UIViewController {
    @IBOutlet weak var animationView: AnimationView! {
        didSet {
            animationView.contentMode = .scaleAspectFit
            animationView.loopMode = .playOnce
            animationView.animationSpeed = 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animationView.play()
    }
}
