//
//  StockDetailViewController.swift
//  StocksApp
//
//  Created by Felix Titov on 11.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit
import Kingfisher

class StockDetailViewController: UIViewController {
    
    //MARK: IB Outlets
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
    
    //MARK: Public properties
    var stock: Stock!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        fetchStockBySymbol(with: stock.symbol)
    }
    
    //MARK: IB Actions
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
}

//MARK: Setup UI
extension StockDetailViewController {
    private func setupInfoScreen(with stock: StockInfo) {
        let imageView = UIImageView()
        let url = URL(string: Constant.iconURL + stock.symbol + ".png")
        
        stockImageView.layer.cornerRadius = stockImageView.frame.height / 2
        
        imageView.kf.setImage(with: url)
        if imageView.image == nil {
            stockImageView.image = UIImage(named: "stock.png")
        } else {
            stockImageView.kf.setImage(with: url)
        }
        
        navNar.title = stock.latestTime
        companyNameLabel.text = stock.companyName
        companySymbolLabel.text = stock.symbol
        
        changePriceLabel.text = String(format: "%.3f", stock.change) + "$"
        changePercentLabel.text = String(format: "%.3f", stock.changePercent) + "%"
        
        if stock.change > 0 {
            setColor(by: .systemGreen)
        } else if stock.change < 0 {
            setColor(by: .systemRed)
        }
        
        priceLabel.text = "\(stock.latestPrice)$"
        openPriceLabel.text = "\(stock.previousClose)$"
        yearMinPriceLabel.text = "\(stock.week52Low)$"
        yearMaxPriceLabel.text = "\(stock.week52High)$"
        
        
        stock.isUSMarketOpen
        ? setTitleforMarketInfo(by: "Market is open!", and: .systemGreen)
        : setTitleforMarketInfo(by: "Market is closed!", and: .systemRed)
    }
    
    private func setColor(by color: UIColor) {
        changePriceLabel.textColor = color
        changePercentLabel.textColor = color
        priceLabel.textColor = color
    }
    
    private func setTitleforMarketInfo(by text: String, and color: UIColor) {
        isMarketCloseLabel.text = text
        isMarketCloseLabel.textColor = color
    }
}

//MARK: Get info from Network
extension StockDetailViewController {
    private func fetchStockBySymbol(with symbol: String) {
        NetworkManager.shared.fetchStockBySymbol(symbol: symbol, completion: { result in
            switch result {
                case .success(let stock):
                    DispatchQueue.main.async {
                        self.setupInfoScreen(with: stock)
                    }
                case .failure(let error):
                    print(error)
                    self.showAlertController(
                        title: "Parsing error!",
                        message: error.localizedDescription
                )
            }
        })
    }
}
