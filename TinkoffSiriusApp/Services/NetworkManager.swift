//
//  NetworkManager.swift
//  TinkoffSiriusApp
//
//  Created by Felix Titov on 11.02.2022.
//  Copyright © 2022 by Felix Titov. All rights reserved.
//  


import Foundation

class NetworkManager {
    
    //Singleton for work with network
    private init() {}
    static let shared = NetworkManager()

    func fetchAllStocks(completion: @escaping (Result<[Stock], Error>) -> ()) {
        guard let url = URL(string: Constant.stocksURL + Route.allStocks.rawValue + Key.apiKeyStocks) else {
            print("URL was not generated.")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            
            do {

                let decoder = JSONDecoder()
                let info = try decoder.decode([Stock].self, from: data)
                completion(.success(info))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchStockBySymbol(symbol: String, completion: @escaping (Result<StockInfo, Error>) -> ()) {
        guard let url = URL(string: Constant.stocksURL + Route.stock.rawValue + "/\(symbol)/quote?" + Key.apiKeyStocks) else {
            print("URL was not generated.")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "unknown error")
                return
            }
            
            do {

                let decoder = JSONDecoder()
                let info = try decoder.decode(StockInfo.self, from: data)
                completion(.success(info))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
