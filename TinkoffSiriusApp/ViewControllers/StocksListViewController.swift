//
//  StocksListViewController.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 10.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class StocksListViewController: UITableViewController {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var stocks: [Stock] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        fetchAllStocks()
    }
    
}

extension StocksListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        stocks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let stock = stocks[indexPath.row]
//        let image = getIconOfStock(for: stock.iconName)
        
        var content = cell.defaultContentConfiguration()
        content.text = stock.symbol
        content.secondaryText = stock.name
//        if let icon = image {
//            content.image = UIImage(data: icon)
//        } else {
//            content.image = UIImage(named: "AAPL.png")
//        }
        content.imageProperties.cornerRadius = tableView.rowHeight/2
        
        cell.contentConfiguration = content
        
        cell.accessoryView = UIImageView(image: UIImage(systemName: "arrow.up"))
        
        cell.accessoryView?.tintColor = .green

        return cell
    }
    
    
    private func fetchAllStocks() {
        NetworkManager.shared.fetchAllStocks() { result in
            switch result {
                case .success(let stocks):
                    self.stocks = stocks
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
    
    private func getIconOfStock(for symbol: String) -> Data? {
        var image: Data? = nil
        
        NetworkManager.shared.fetchIconForStock(for: symbol) { result in
            switch result {
            case .success(let data):
                image = data
            case .failure( _):
                    break
            }
        }
        
        return image
    }
}
