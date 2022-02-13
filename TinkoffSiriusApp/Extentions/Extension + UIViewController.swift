//
//  Extension + UIViewController.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 13.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation
import UIKit

extension UIViewController {
    func showAlertController(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
}
