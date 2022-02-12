//
//  StockDetailViewController.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 11.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit
import Kingfisher

class StockDetailViewController: UIViewController {

    @IBOutlet var navNar: UINavigationItem!
    
    @IBOutlet var stockImageView: UIImageView!
    
    @IBOutlet var companyNameLabel: UILabel!
    @IBOutlet var companySymbolLabel: UILabel!
    
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var changePriceLabel: UILabel!
    @IBOutlet var changePercentLabel: UILabel!
    @IBOutlet var openPriceLabel: UILabel!
    @IBOutlet var yearMinPriceLabel: UILabel!
    @IBOutlet var yearMaxPriceLabel: UILabel!
    
    @IBOutlet var isMarketCloseLabel: UILabel!
    var stock: Stock!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stockImageView.layer.cornerRadius = stockImageView.frame.height / 2
        
        fetchIconByStock(with: stock.symbol)
        fetchStockBySymbol(with: stock.symbol)
        
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

extension StockDetailViewController {
    
    private func setupInfoScreen(with stock: StockInfo) {
        
        navNar.title = stock.latestTime
        companyNameLabel.text = stock.companyName
        companySymbolLabel.text = stock.symbol
        
        changePriceLabel.text = String(format: "%.2f", stock.change) + "$"
        changePercentLabel.text = String(format: "%.3f", stock.changePercent) + "%"
        
        if stock.change > 0 {
            setColor(by: .green)
        } else if stock.change < 0 {
            setColor(by: .red)
        }
        
        priceLabel.text = "\(stock.latestPrice)$"
        openPriceLabel.text = "\(stock.previousClose)$"
        yearMinPriceLabel.text = "\(stock.week52Low)$"
        yearMaxPriceLabel.text = "\(stock.week52High)$"
        
        if stock.isUSMarketOpen {
            isMarketCloseLabel.text = "Market is open!"
            isMarketCloseLabel.textColor = .green
        } else {
            isMarketCloseLabel.text = "Market is closed!"
            isMarketCloseLabel.textColor = .red
        }
        
    }
    
    private func setColor(by color: UIColor) {
        changePriceLabel.textColor = color
        changePercentLabel.textColor = color
        priceLabel.textColor = color
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
    
    private func fetchIconByStock(with symbol: String) {
        NetworkManager.shared.fetchIconByStock(symbol: symbol, completion: { result in
            switch result {
                case .success(let stock):
                    DispatchQueue.main.async {
                        let url = URL(string: stock.logo)
                        self.stockImageView.kf.setImage(with: url)
                    }
                
                case .failure(let error):
                    print(error)
            }
        })
    }
}

