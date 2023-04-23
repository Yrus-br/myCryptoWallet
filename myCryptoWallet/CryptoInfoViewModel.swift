//
//  CryptoInfoViewModel.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 23.04.2023.
//

import Foundation

protocol CryptoInfoViewModelProtocol {
    var cryptoName: String { get }
    var cryptoRank: String { get }
    var cryptoSymbol: String? { get }
    var cryptoSupply: String? { get }
    var cryptoMaxSupply: String? { get }
    var cryptoMarketCapUsd: String? { get }
    var cryptoVolumeUsd24Hr: String? { get }
    var cryptoPriceUsd: String? { get }
    var cryptoChangePercent24Hr: String? { get }
    var cryptoVwap24Hr: String? { get }
    var cryptoExplorer: String? { get }
    
    init(crypto: CurrencyInfo)
}

class CryptoInfoViewModel: CryptoInfoViewModelProtocol {
    
    private let crypto: CurrencyInfo
    
    var cryptoName: String {
        crypto.name
    }
    
    var cryptoRank: String {
        crypto.rank
    }
    
    var cryptoSymbol: String? {
        crypto.symbol
    }
    
    var cryptoSupply: String? {
        crypto.supply
    }
    
    var cryptoMaxSupply: String? {
        crypto.maxSupply
    }
    
    var cryptoMarketCapUsd: String? {
        crypto.marketCapUsd
    }
    
    var cryptoVolumeUsd24Hr: String? {
        crypto.volumeUsd24Hr
    }
    
    var cryptoPriceUsd: String? {
        crypto.priceUsd
    }
    
    var cryptoChangePercent24Hr: String? {
        crypto.changePercent24Hr
    }
    
    var cryptoVwap24Hr: String? {
        crypto.vwap24Hr
    }
    
    var cryptoExplorer: String? {
        crypto.explorer
    }
    
    required init(crypto: CurrencyInfo) {
        self.crypto = crypto
    }
    
}

