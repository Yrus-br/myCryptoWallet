//
//  CryptoListViewModel.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 18.04.2023.
//

import Foundation

protocol CryptoListViewModelProtocol {
    var allCurrencys: [CurrencyInfo] { get }
    var filteredCurrencys: [CurrencyInfo] { get set }
    
    func getData(completion: @escaping () -> Void)
    func numberOfRows() -> Int
    func cellViewModel(for index: IndexPath) -> CryptoCellViewModelProtocol?
    func cellForFilteredCurrencys(for index: IndexPath) -> CurrencyInfo?
    func getCryptoInfoViewModel(for index: IndexPath) -> CryptoInfoViewModel?
}

class CryptoListViewModel: CryptoListViewModelProtocol {
    
    func getCryptoInfoViewModel(for index: IndexPath) -> CryptoInfoViewModel? {
        CryptoInfoViewModel(crypto: allCurrencys[index.row])
    }
    
    func cellForFilteredCurrencys(for index: IndexPath) -> CurrencyInfo? {
        guard isFiltering else { return nil }
        return filteredCurrencys[safe: index.row]
    }
    
    var allCurrencys: [CurrencyInfo] = []
    var filteredCurrencys: [CurrencyInfo] = []
    
    init() {
        allCurrencys = []
        filteredCurrencys = []
    }
    
    func getData(completion: @escaping () -> Void) {
        Task {
            do {
                let Currencys = try await NetworkManager.shared.fetchData()
                allCurrencys = Currencys.data
                completion()
            } catch let error {
                print(error)
            }
        }
    }
    
    func cellViewModel(for index: IndexPath) -> CryptoCellViewModelProtocol? {
        guard let currency = getCurrencys(for: index) else {
            return nil
        }
        return CryptoCellViewModel(currency: currency)
    }
    
    func getCurrencys(for index: IndexPath) -> CurrencyInfo? {
        if isFiltering {
            return filteredCurrencys[safe: index.row]
        } else {
            return allCurrencys[safe: index.row]
        }
    }
    
    func numberOfRows() -> Int {
        if isFiltering {
            return numberOfFilteredRows()
        } else {
            return allCurrencys.count
        }
    }
    
    func filterCurrencys(for searchText: String) {
        filteredCurrencys = allCurrencys.filter { currency in
            return currency.name.lowercased().contains(searchText.lowercased())
        }
    }
    
    func numberOfFilteredRows() -> Int {
        return filteredCurrencys.count
    }
    
    func filteredCellViewModel(for index: IndexPath) -> CryptoCellViewModelProtocol? {
        guard let currency = filteredCurrencys[safe: index.row] else {
            return nil
        }
        return CryptoCellViewModel(currency: currency)
    }
    
    private var isFiltering: Bool {
        return !filteredCurrencys.isEmpty
    }
}

extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
