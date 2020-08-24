//
//  AmountViewController.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/23/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var nextStepButton: UIButton!
    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLabels()
        setupTextField()
        setupButton()
        setupGestureRecognizer()
        setupKeyboardNotifications()
    }

    // MARK: Private
    private func setupButton() {
        nextStepButton.clipsToBounds = true
        nextStepButton.layer.cornerRadius = Constants.buttonCornerRadious
        nextStepButton.setTitle(Localizables.nextButtonTitle, for: .normal)
        nextStepButton.setTitleColor(.white, for: .normal)
        nextStepButton.backgroundColor = .appGreen
    }

    private func setupGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }

    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
      
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        
    }

    @objc
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue)?.cgRectValue else {
           return
        }
        UIView.animate(withDuration: 0.5) {
            self.buttonBottomConstraint.constant = 16 + keyboardSize.height
        }
    }

    @objc
    func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.buttonBottomConstraint.constant = 16
        }
    }

    private func setupLabels() {
        titleLabel.text = Localizables.amountTitle
        titleLabel.textColor = .black
        subtitleLabel.text = Localizables.amountSubtitle
        titleLabel.textColor = .secondaryLabel
    }

    private func setupTextField() {
        amountTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
        amountTextField.placeholder = Constants.textFieldPlaceholder
    }

    @objc
    private func myTextFieldDidChange(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting {
            textField.text = amountString
        }
        
    }

    // MARK: - Actions
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
    }
}
