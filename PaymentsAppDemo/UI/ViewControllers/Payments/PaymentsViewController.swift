//
//  PaymentsViewController.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

struct PaymentInfo {
    let imageURL: String
    let name: String
}

class PaymentsViewController: BaseViewController {
    @IBOutlet weak private var stepsContainerView: UIView! {
        didSet {
//            let stepView: StepsUIView = StepsUIView.loadFirstSubViewFromNib() as! StepsUIView
//            stepsContainerView.addSubview(stepView)
//            stepView.frame = stepsContainerView.bounds
        }
    }
    @IBOutlet weak private var paymentTitleLabel: UILabel!
    @IBOutlet weak private var paymentTableView: UITableView! {
        didSet {
            paymentTableView.delegate = self
            paymentTableView.dataSource = self
            paymentTableView.register(UINib(nibName: PaymentsTableViewCell.className, bundle: nil),
                                      forCellReuseIdentifier: PaymentsTableViewCell.className)
        }
    }

    private let viewModel: PaymentsViewModel

    init(viewModel: PaymentsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: PaymentsViewController.className, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.getPaymentMethods { [weak self] in
            self?.paymentTableView.reloadData()
        }
    }

    private func handleRowSelected(isLastStep: Bool, isEmpty: Bool) {
        if isLastStep {
            let successView: SuccessViewController = SuccessViewController.loadFromNib()
            navigationController?.pushViewController(successView, animated: true)
        } else if isEmpty {
            showAlertMessage(title: Localizables.paymentsEmptyTitle,
                             message: Localizables.paymentsEmptyMessage)
        } else {
            updateViewController()
        }
    }

    private func updateViewController() {
        paymentTableView.reloadData()
        paymentTitleLabel.text = viewModel.currentStepTitle
        paymentTitleLabel.textColor = .darkGray
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        if viewModel.previousStep() {
            updateViewController()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Table View
extension PaymentsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInCurrentStep()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PaymentsTableViewCell.className) as? PaymentsTableViewCell,
            let paymentInfo = viewModel.getPaymentInfo(forIndex: indexPath) else {
            return UITableViewCell()
        }
        
        cell.setupCell(withImageURL: paymentInfo.imageURL, andName: paymentInfo.name)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRowAt(index: indexPath) { [weak self] lastStep, isEmpty in
            self?.handleRowSelected(isLastStep: lastStep, isEmpty: isEmpty)
        }
    }
}
