//
//  StocksListViewController.swift
//  StocksApp
//
//  Created by Felix Titov on 10.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit
import Kingfisher

class StocksListViewController: UITableViewController {
    
    //MARK: IB Outlets
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    //MARK: Private properties
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var stocks: [Stock] = []
    private var filteredStocks: [Stock] = []
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        setupSearchController()
        fetchAllStocks()
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let stockDetailVC = navigationVC.topViewController as? StockDetailViewController else { return }
        
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        
        var stock: Stock
        
        if isFiltering {
            stock = filteredStocks[indexPath.row]
        } else {
            stock = stocks[indexPath.row]
        }
        
        stockDetailVC.stock = stock
    }
}

//MARK: Work with tableView
extension StocksListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredStocks.count
        }
        return stocks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        let imageView = UIImageView()
        var stock: Stock
    
        if isFiltering {
            stock = filteredStocks[indexPath.row]
        } else {
            stock = stocks[indexPath.row]
        }
        
        let url = URL(string: Constant.iconURL + stock.symbol + ".png")
        imageView.kf.setImage(with: url)
        
        var content = cell.defaultContentConfiguration()
        content.text = stock.symbol
        content.secondaryText = stock.name
        
        if imageView.image == nil {
            content.image = UIImage(named: "stock.png")
        } else {
            content.image = imageView.image
        }
    
        content.imageProperties.maximumSize = CGSize(
            width: tableView.rowHeight - 20,
            height: tableView.rowHeight - 20
        )
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        
        cell.contentConfiguration = content
        
        return cell
    }
}

//MARK: Work with search
extension StocksListViewController: UISearchResultsUpdating {
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContetntForSearchText(searchText: searchController.searchBar.text ?? "")
    }
    
    private func filterContetntForSearchText(searchText: String) {
        filteredStocks = stocks.filter({ (stock: Stock) -> Bool in
            return stock.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
}

//MARK: Get info from Network
extension StocksListViewController {
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
                    self.showAlertController(
                        title: "Parsing error!",
                        message: error.localizedDescription
                    )
            }
        }
    }
}
