//
//  StoksViewController.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 09.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import UIKit

class StoksViewController: UIViewController {

    @IBOutlet var companyNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        companyNameLabel.text = "Tinkoff"
    }

}

