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
        guard let url = URL(string: Constant.stocksURL + Route.allStocks.rawValue) else {
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
                let info = try decoder.decode([FailableDecodable<Stock>].self, from: data)
                    .compactMap { $0.base }
                completion(.success(info))
            } catch let error {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func fetchIconForStock(for symbol: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: Constant.iconURL + symbol) else {
            print("URL was not generated.")
            return
            
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                    
                completion(.failure(error as! Error))
                return
            }
            completion(.success(data))

        }.resume()
    }
}
