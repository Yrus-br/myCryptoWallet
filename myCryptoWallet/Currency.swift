//
//  Currency.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 30.03.2023.
//

struct Currency: Decodable {
    let data: [Info]
    let timestamp: Int
}

struct Info: Decodable {
    let id: String
    let rank: String?
    let symbol: String?
    let name: String?
    let supply: String?
    let maxSupply: String?
    let marketCapUsd: String?
    let volumeUsd24Hr: String?
    let priceUsd: String?
    let changePercent24Hr: String?
    let vwap24Hr: String?
    let explorer: String?

}
