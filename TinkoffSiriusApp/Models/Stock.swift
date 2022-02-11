//
//  Stock.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 10.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

struct FailableDecodable<Base : Decodable> : Decodable {

    let base: Base?

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.base = try? container.decode(Base.self)
    }
}

struct Stock: Codable {
    
    let name: String
    let symbol: String
//    let open: Double
//    let high: Double
//    let low: Double
    
    var iconName: Data
}

struct AllStocksDescription: Codable {
    let assets: [Stock]
}
