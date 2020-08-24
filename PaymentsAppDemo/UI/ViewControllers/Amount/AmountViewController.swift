//
//  AmountViewController.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/23/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class AmountViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Localizables.amountTitle
            titleLabel.textColor = .darkGray
        }
    }

    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.text = Localizables.amountSubtitle
            subtitleLabel.textColor = .secondaryLabel
        }
    }

    @IBOutlet weak var amountTextField: UITextField! {
        didSet {
            amountTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
            amountTextField.placeholder = Constants.textFieldPlaceholder
        }
    }

    @IBOutlet weak var nextStepButton: UIButton! {
        didSet {
            nextStepButton.clipsToBounds = true
            nextStepButton.layer.cornerRadius = Constants.buttonCornerRadious
            nextStepButton.setTitle(Localizables.nextButtonTitle, for: .normal)
            nextStepButton.setTitleColor(.white, for: .normal)
            nextStepButton.backgroundColor = .appGreen
        }
    }

    @IBOutlet weak var buttonBottomConstraint: NSLayoutConstraint!

    let viewModel = AmountViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupGestureRecognizer()
        setupKeyboardNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.setToolbarHidden(true, animated: false)
    }

    // MARK: - Private
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
    private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
            NSValue)?.cgRectValue else {
           return
        }
        UIView.animate(withDuration: 0.5) {
            self.buttonBottomConstraint.constant = 16 + keyboardSize.height
        }
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.5) {
            self.buttonBottomConstraint.constant = 16
        }
    }

    @objc
    private func myTextFieldDidChange(_ textField: UITextField) {
        if let textFieldText = textField.text {
            textField.text = viewModel.toCurrencyFormat(textFieldText)
        }
    }

    // MARK: - Actions
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard let textFieldText = amountTextField.text else { return }
        let paymentsViewModel = PaymentsViewModel(amount: viewModel.stringToFloat(textFieldText))
        let paymentsViewController = PaymentsViewController(viewModel: paymentsViewModel)
        navigationController?.pushViewController(paymentsViewController, animated: true)
    }
}
