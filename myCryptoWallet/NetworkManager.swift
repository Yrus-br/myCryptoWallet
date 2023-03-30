//
//  NetworkManager.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 30.03.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    
    func fetchData() async throws -> Currency {
        
        guard let url = URL(string: "https://api.coincap.io/v2/assets") else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let currencys: Currency
        do {
            currencys = try decoder.decode(Currency.self, from: data)
        }
        catch let error {
            print(error.localizedDescription)
            throw NetworkError.noData
        }
        return currencys
    }
    
}

