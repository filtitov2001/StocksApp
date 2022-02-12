//
//  StocksListViewController.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 10.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit
import Kingfisher

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
        
        var content = cell.defaultContentConfiguration()
        content.text = stock.symbol
        content.secondaryText = stock.name
        
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let stockDetailVC = navigationVC.topViewController as? StockDetailViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        stockDetailVC.stock = stocks[indexPath.row]
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
}
