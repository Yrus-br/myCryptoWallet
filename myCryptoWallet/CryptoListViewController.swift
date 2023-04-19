//
//  CryptoListViewController.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 06.03.2023.
//

import UIKit


class CryptoListViewController: UITableViewController, UISearchControllerDelegate {
    
    private var viewModel: CryptoListViewModelProtocol!
    
    private let reuseIdentifier = "Cell"
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    init(viewModel: CryptoListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CryptoCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        viewModel.getData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        
        setupSearchController()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return viewModel.filteredCurrencys.count
        } else {
            return viewModel.numberOfRows()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! CryptoCell
        if isFiltering {
            cell.viewModel = viewModel.cellForFilteredCurrencys(for: indexPath).flatMap { CryptoCellViewModel(currency: $0) }
        } else {
            cell.viewModel = viewModel.cellViewModel(for: indexPath)
        }
        return cell
    }
    
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.barTintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.font = UIFont.boldSystemFont(ofSize: 17)
            textField.textColor = .blue
        }
        
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        viewModel.filteredCurrencys = viewModel.allCurrencys.filter { (crypto: CurrencyInfo) -> Bool in
            return crypto.name.lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
}

extension CryptoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}

