//
//  CryptoListViewController.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 06.03.2023.
//

import UIKit


class CryptoListViewController: UITableViewController, UISearchResultsUpdating {
    
    private let reuseIdentifier = "Cell"
    
    private var allCurrencys: Currency?
    private var currencyArray: [Info] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        getData()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? currencyArray.count : allCurrencys?.data.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        let currency = isFiltering ? currencyArray[indexPath.row] : allCurrencys?.data[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = currency?.name
        cell.contentConfiguration = content
        return cell
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
    
    private func getData() {
        Task {
            do {
                allCurrencys = try await NetworkManager.shared.fetchData()
                tableView.reloadData()
            } catch let error {
                print(error)
            }
        }
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        currencyArray = allCurrencys?.data.filter { character in
            character.id.lowercased().contains(searchText.lowercased())
        } ?? []
        
        tableView.reloadData()
    }
    
}


