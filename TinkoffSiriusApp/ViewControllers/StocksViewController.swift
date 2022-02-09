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
    @IBOutlet var symbolLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var priceChangeLabel: UILabel!
    
    
    @IBOutlet var companyNamesPickerView: UIPickerView!
    @IBOutlet var actitvityIndicator: UIActivityIndicatorView!
    
    private let apiKey = "pk_33e1a23d8c1a4260af70fe9912e96971"
    
    private let companies: [String: String] = ["Apple": "AAPL",
                                "Microsoft": "MSFT",
                                "Google": "GOOG",
                                "Amazon": "AMZN",
                                "Facebook": "FB" ]
                                
    override func viewDidLoad() {
        super.viewDidLoad()
        
        companyNamesPickerView.dataSource = self
        companyNamesPickerView.delegate = self
        
        actitvityIndicator.hidesWhenStopped = true
        
        requireQuoteUpdate()
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        actitvityIndicator.startAnimating()
        companyNameLabel.text = "-"
        
        let selectedStock = Array(companies.values)[row]
        requestQuote(for: selectedStock)
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
    
    private func requireQuoteUpdate() {
        actitvityIndicator.startAnimating()
        
        let selectedRow = companyNamesPickerView.selectedRow(inComponent: 0)
        let selectedSymbol = Array(companies.values)[selectedRow]
        
        requestQuote(for: selectedSymbol)
    }
    
    private func parseQuote(for data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data)
            
            guard
                let json = jsonObject as? [String: Any],
                let companyName = json["companyName"] as? String,
                let symbolName = json["symbol"] as? String,
                let price = json["latestPrice"] as? Double,
                let PriceChange = json["change"] as? Double
            else {
                print("Invalid Json format!")
                return
            }
            DispatchQueue.main.async { [self] in
                self.displayStockInfo(companyName: companyName,
                                      symbolName: symbolName,
                                      price: price,
                                      PriceChange: PriceChange)
            }
        } catch {
            print("Json parsing error" + error.localizedDescription)
        }
    }
    
    private func displayStockInfo(companyName: String,
                                  symbolName: String,
                                  price: Double,
                                  PriceChange: Double) {
        actitvityIndicator.stopAnimating()
        
        companyNameLabel.text = companyName
        symbolLabel.text = symbolName
        priceLabel.text = "\(price)"
        priceChangeLabel.text = "\(PriceChange)"
        
    }
}

