//
//  StocksListViewController.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 10.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class StocksListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 80

        // Do any additional setup after loading the view.
    }
    
}

extension StocksListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath)
        
        var content = cell.defaultContentConfiguration()
        content.text = "AAPL"
        content.secondaryText = "Apple Inc."
        content.image = UIImage(named: "AAPL.png")
        content.imageProperties.cornerRadius = tableView.rowHeight/2
        cell.contentConfiguration = content
        
        
        return cell
    }
    
}
