//
//  StoksViewController.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 09.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class StocksViewController: UIViewController {

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
        
        companyNamesPickerView.dataSource = self
        companyNamesPickerView.delegate = self
    }

}

//MARK: Work with UIPickerView
extension StocksViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        companies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        Array(companies.keys)[row]
    }
}


