//
//  StockDetailViewController.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 11.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class StockDetailViewController: UIViewController {

    @IBOutlet var stockImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!
    
    @IBOutlet var companySymbolLabel: UILabel!
    
    var stock: Stock!
    var currentStock: [StockInfo] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchStockBySymbol(with: stock.symbol)
        
        print(currentStock)
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension StockDetailViewController {
    
    private func setupInfoScreen(with stock: StockInfo) {
 

        print(stock.symbol)

        companySymbolLabel.text = stock.symbol
    }
    
    private func fetchStockBySymbol(with symbol: String) {
        
        NetworkManager.shared.fetchStockBySymbol(symbol: symbol, completion: { result in
            switch result {
                case .success(let stock):
                    DispatchQueue.main.async {
                        self.setupInfoScreen(with: stock)
                    }
                
                case .failure(let error):
                    print(error)
            }
        })
        
    }
}

