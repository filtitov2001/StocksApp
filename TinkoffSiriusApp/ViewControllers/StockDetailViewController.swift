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
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let image = UIImage(named: "V.png")
//        stockImageView.frame.height = image.size
        
        
    }
    
    override func viewWillLayoutSubviews() {
        print(stockImageView.frame.height)
        print(stockImageView.frame.width)
    }
    
}
