//
//  Routes.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 11.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

enum Route: String {
    case allStocks = "ref-data/symbols?token=pk_33e1a23d8c1a4260af70fe9912e96971"
    case stock = "stock/AAPL/quote?&token=pk_33e1a23d8c1a4260af70fe9912e96971"
}
