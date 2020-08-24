//
//  PaymentsViewController.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

enum PaymentsSteps: Int {
    case paymentMethods
    case cardIssuers
    case installments
}

struct PaymentInfo {
    let imageURL: String
    let name: String
}

class PaymentsViewController: UIViewController {
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

        // Do any additional setup after loading the view.
        viewModel.getPaymentMethods { [weak self] in
            self?.paymentTableView.reloadData()
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
}
