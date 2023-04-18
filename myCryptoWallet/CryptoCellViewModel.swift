//
//  CryptoCellViewModel.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 18.04.2023.
//

import Foundation

protocol CryptoCellViewModelProtocol {
    var cryptoName: String { get }
    init(currency: CurrencyInfo)
}

class CryptoCellViewModel: CryptoCellViewModelProtocol {
    var cryptoName: String {
        currency.name
    }
    
    private let currency: CurrencyInfo
    
    required init(currency: CurrencyInfo) {
        self.currency = currency
    }
}
