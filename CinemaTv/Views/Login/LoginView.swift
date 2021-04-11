//
//  LoginView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 22/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

protocol LoginViewDelegate: AnyObject {
    func didTapLogin()
    func didTapGoToRegistration()
}

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    public var emailText: String? {
        get { emailField.text }
        set { emailField.text = newValue
            emailField.sendActions(for: .editingChanged)
        }
    }
    
    public var passwordText: String? {
        get { passwordField.text }
        set { passwordField.text = newValue
            passwordField.sendActions(for: .editingChanged)
        }
    }
    
    
    private let mainView: UIView = {
    let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    return view
    }()
    
    private let imageLogin: UIImageView = {
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
    
    private(set) lazy var emailField: UITextField = {
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
        
        textField.text = "danilo.requena26@gmail.com"
        
        return textField
    }()
    
    private(set) lazy var passwordField: UITextField = {
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
        
        textField.text = "123456"
        
        return textField
    }()
    
    private let buttonGo: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signin), for: .touchUpInside)
        
        return button
    }()
    
    private let buttonRegistration: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("SignUp", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(goToRegistration), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc
    func signin() {
        delegate?.didTapLogin()
    }
    
    @objc
    func goToRegistration() {
        delegate?.didTapGoToRegistration()
    }
}

extension LoginView: CodeView {
    func buildViewHierarchy() {
        addSubview(mainView)
        mainView.addSubviews(
            imageLogin,
            titleLabel,
            emailField,
            passwordField,
            buttonGo,
            buttonRegistration
        )
    }
    
    func setupConstraints() {
        mainView.bindFrameToSuperviewBounds()
        
        imageLogin.anchor(
            top: mainView.topAnchor,
            leading: mainView.leadingAnchor,
            trailing: mainView.trailingAnchor,
            insets: .init(inset: 16)
        )
        imageLogin.anchor(height: 180, width: 180)
        imageLogin.anchorCenterXTo(view: mainView)
        
        titleLabel.anchor(
            top: imageLogin.bottomAnchor,
            leading: mainView.leadingAnchor,
            trailing: mainView.trailingAnchor,
            insets: .init(inset: 16)
        )
        titleLabel.anchor(height: 42)
        
        emailField.anchor(
            top: titleLabel.bottomAnchor,
            leading: mainView.leadingAnchor,
            trailing: mainView.trailingAnchor,
            insets: .init(top: 42, left: 16, bottom: 0, right: 16)
        )
        emailField.anchor(height: 52)
        
        passwordField.anchor(
            top: emailField.bottomAnchor,
            leading: mainView.leadingAnchor,
            trailing: mainView.trailingAnchor,
            insets: .init(top: 22, left: 16, bottom: 0, right: 16)
        )
        passwordField.anchor(height: 52)
        
        buttonGo.anchor(
            top: passwordField.bottomAnchor,
            leading: mainView.leadingAnchor,
            trailing: mainView.trailingAnchor,
            insets: .init(top: 48, left: 16, bottom: 0, right: 16)
        )
        buttonGo.anchor(height: 52)
        
        buttonRegistration.anchor(
            top: buttonGo.bottomAnchor,
            leading: mainView.leadingAnchor,
            bottom: mainView.bottomAnchor,
            trailing: mainView.trailingAnchor,
            insets: .init(top: 22, left: 16, bottom: 16, right: 16)
        )
        buttonRegistration.anchor(height: 52)
    }
}
