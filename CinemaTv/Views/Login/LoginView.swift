//
//  LoginView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 22/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class LoginView: UIView {
    private let imagaTitle: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "loginTitle")
        image.sizeToFit()
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 27)
        
       return label
    }()
    
    private let emailField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "E-mail Address"
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        return textField
    }()
    
    private let passwordField: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10
        textField.keyboardType = .numberPad
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        
        return textField
    }()
    
    private let buttonGo: UIButton = {
        let button = UIButton()
         button.backgroundColor = .systemGreen
         button.setTitleColor(.white, for: .normal)
         button.setTitle("Continue", for: .normal)
         button.layer.cornerRadius = 10
        
         return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(imagaTitle)
        addSubview(titleLabel)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(buttonGo)
        
        imagaTitle.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imagaTitle).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        emailField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.top.equalTo(emailField).inset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        buttonGo.snp.makeConstraints { (make) in
            make.top.equalTo(passwordField).inset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
