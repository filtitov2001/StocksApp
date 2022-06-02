//
//  StartViewController.swift
//  StocksApp
//
//  Created by Felix Titov on 13.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkInternetConnection()
    }
    
    private func checkInternetConnection() {
        if !NetworkMonitor.shared.isConnected {
            showAlertController(
                title: "Internet error!",
                message: "Check your internet connection!"
            )
        }
    }
    
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue) {
        dismiss(animated: true)
    }
}
