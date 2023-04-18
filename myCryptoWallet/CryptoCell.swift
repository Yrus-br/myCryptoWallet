//
//  CryptoCell.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 18.04.2023.
//

import UIKit

class CryptoCell: UITableViewCell {
    var viewModel: CryptoCellViewModelProtocol! {
        didSet {
            var content = defaultContentConfiguration()
            content.text = viewModel.cryptoName
            contentConfiguration = content
        }
    }
}
