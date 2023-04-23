//
//  CryptoInfoViewController.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 23.04.2023.
//

import UIKit
import SnapKit

final class CryptoInfoViewController: UIViewController {
    
    var viewModel: CryptoInfoViewModelProtocol!
    
    let cryptoNameLabel = UILabel()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        view.backgroundColor = .white
        initialise()
    }
    
    private func  initialise() {
        
        view.addSubview(cryptoNameLabel)
        
        cryptoNameLabel.text = viewModel.cryptoName
        
        
        cryptoNameLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            
        }
    }
    
    
}
