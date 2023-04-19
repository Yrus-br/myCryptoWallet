//
//  ViewController.swift
//  myCryptoWallet
//
//  Created by Jorgen Shiller on 06.03.2023.
//

import UIKit
import SnapKit

final class LogInViewController: UIViewController {
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Hey! Welcome! 🪙"
        label.font = .italicSystemFont(ofSize: 30)
        return label
    }()
    
    let logInTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "LOGIN"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    let passwordTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "PASSWORD"
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.isSecureTextEntry = true
        let showPasswordButton = UIButton(type: .custom)
        showPasswordButton.setImage(UIImage(systemName: "eye"), for: .normal)
        
        // TODO: разобраться почему выдает ошибку, возможно нужно поменять местоположение TF
        showPasswordButton.addTarget(self, action: #selector(showPasswordButtonTapped), for: .touchUpInside)
        textField.rightView = showPasswordButton
        textField.rightViewMode = .always
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initialise()
    }
    
    @objc private func showPasswordButtonTapped(sender: UIButton) {
        passwordTF.isSecureTextEntry.toggle()
        let imageName = passwordTF.isSecureTextEntry ? "eye" : "eye.slash"
        sender.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    @objc private func confirmlogIn() {
        let viewModel = CryptoListViewModel()
        let viewController = CryptoListViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private  func initialise() {
        view.backgroundColor = UIColor(red: 241/255,
                                       green: 238/255,
                                       blue: 228/255,
                                       alpha: 1)
        let confirmButton: UIButton = {
            var attributes = AttributeContainer()
            attributes.font = UIFont.boldSystemFont(ofSize: 18)
            
            var buttonConfiguration = UIButton.Configuration.filled()
            buttonConfiguration.baseBackgroundColor = UIColor(named: "ButtonColor")
            buttonConfiguration.attributedTitle = AttributedString("Confirm", attributes: attributes)
            
            let button = UIButton(configuration: buttonConfiguration, primaryAction: UIAction { [unowned self] _ in confirmlogIn() } )
            
            return button
        }()
        
        let forgotPassButton: UIButton = {
            var attributes = AttributeContainer()
            attributes.font = UIFont.boldSystemFont(ofSize: 18)
            
            var buttonConfiguration = UIButton.Configuration.filled()
            buttonConfiguration.baseBackgroundColor = UIColor(named: "ButtonColor")
            buttonConfiguration.attributedTitle = AttributedString("Forgot Password?", attributes: attributes)
            
            let button = UIButton(configuration: buttonConfiguration, primaryAction: UIAction { [unowned self] _ in dismiss(animated: true) })
            
            return button
        }()
        
        
        
        view.addSubview(welcomeLabel)
        view.addSubview(logInTF)
        view.addSubview(passwordTF)
        view.addSubview(confirmButton)
        view.addSubview(forgotPassButton)
        
        welcomeLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(100)
        }
        
        logInTF.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(300)
            $0.height.equalTo(50)
            $0.width.equalTo(300)
        }
        
        passwordTF.snp.makeConstraints {
            $0.top.equalTo(logInTF.snp.bottom).offset(15)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(logInTF)
        }
        
        confirmButton.snp.makeConstraints {
            $0.top.equalTo(passwordTF.snp.bottom).offset(15)
            $0.size.equalTo(logInTF).dividedBy(3)
            $0.right.equalToSuperview().inset(50)
        }
        
        forgotPassButton.snp.makeConstraints {
            $0.top.equalTo(passwordTF.snp.bottom).offset(15)
            $0.left.equalToSuperview().inset(50)
            $0.height.equalTo(confirmButton)
        }
    }
    
}


