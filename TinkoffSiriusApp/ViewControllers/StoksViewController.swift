//
//  StoksViewController.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 09.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class StoksViewController: UIViewController {

    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var companyNamesPickerView: UIPickerView!
    
    private let companies: [String: String] = ["Apple": "AAPL",
                                "Microsoft": "MSFT",
                                "Google": "GOOG",
                                "Amazon": "AMN",
                                "Facebook": "FB" ]
                                
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameLabel.text = "Tinkoff"
    }

}

