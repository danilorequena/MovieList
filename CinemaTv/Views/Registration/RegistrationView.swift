//
//  RegistrationView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 28/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import SnapKit

final class RegistrationView: UIView {
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loginTitle")
        image.sizeToFit()
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 27)
        label.textAlignment = .center
        label.textColor = .white
        
       return label
    }()
    
    private let emailField: UITextField = {
       let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "e-mail",
                                                             attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.textColor = .lightGray
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 10
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        return textField
    }()
    
    private let passwordField: UITextField = {
       let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "password",
                                                             attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        textField.textColor = .lightGray
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 10
        textField.keyboardType = .numberPad
        textField.autocapitalizationType = .none
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        
        return textField
    }()
    
    private let buttonRegister: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
         button.setTitleColor(.white, for: .normal)
         button.setTitle("Continue", for: .normal)
         button.layer.cornerRadius = 10
        
         return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RegistrationView: CodeView {
    func buildViewHierarchy() {
        addSubview(image)
    }
    
    func setupConstraints() {
        image.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            bottom: bottomAnchor,
            trailing: trailingAnchor,
            insets: .init(top: 16, left: 42, bottom: 16, right: 42)
        )
    }
    
    
}
