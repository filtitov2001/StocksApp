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
    @IBOutlet var actitvityIndicator: UIActivityIndicatorView!
    
    private let apiKey = "pk_33e1a23d8c1a4260af70fe9912e96971"
    
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
        
        actitvityIndicator.hidesWhenStopped = true
        
        actitvityIndicator.startAnimating()
        requestQuote(for: "AAPL")
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

//MARK: Work with network
extension StocksViewController {
    private func requestQuote(for symbol: String) {
        let url = URL(string: "https://cloud.iexapis.com/stable/stock/\(symbol)/quote?&token=\(apiKey)")!
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                error == nil,
                (response as? HTTPURLResponse)?.statusCode == 200,
                let data = data
            else {
                print("Network error!")
                return
            }
            
            self.parseQuote(for: data)
        }
        
        dataTask.resume()
        
    }
    
    private func parseQuote(for data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [String: Any],
                let companyName = json["companyName"] as? String
            else {
                print("Invalid Json format!")
                return
            }
            DispatchQueue.main.async { [self] in
                self.displayStockInfo(for: companyName)
            }
        } catch {
            print("Json parsing error" + error.localizedDescription)
        }
    }
    
    private func displayStockInfo(for companyName: String) {
        companyNameLabel.text = companyName
        actitvityIndicator.stopAnimating()
    }
}

