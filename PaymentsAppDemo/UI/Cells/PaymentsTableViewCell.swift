//
//  PaymentsTableViewCell.swift
//  PaymentsAppDemo
//
//  Created by Laura Sofia Cantero Hernandez on 8/24/20.
//  Copyright © 2020 Sofia Cantero. All rights reserved.
//

import UIKit

class PaymentsTableViewCell: UITableViewCell {
    @IBOutlet weak var paymentImageView: UIImageView!
    @IBOutlet weak var paymentNameLabel: UILabel!
    
    func setupCell(withImageURL url: String, andName name: String) {
        paymentImageView.requestImage(urlString: url)
        paymentImageView.clipsToBounds = true
        paymentImageView.layer.cornerRadius = 2
        paymentNameLabel.text = name
        paymentNameLabel.textColor = .darkText
    }
}
