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
import FirebaseAuth

final class LoginView: UIView {
    public var emailText: String? {
        get { emailField.text }
    }
    
    public var passwordText: String? {
        get { passwordField.text }
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
    
    private let buttonGo: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
         button.setTitleColor(.white, for: .normal)
         button.setTitle("Continue", for: .normal)
         button.layer.cornerRadius = 10
        
         return button
    }()
    
    private let buttonRegistration: UIButton = {
        let button = UIButton()
         button.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
         button.setTitleColor(.white, for: .normal)
         button.setTitle("SignUp", for: .normal)
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
        addSubview(mainView)
        mainView.addSubview(imageLogin)
        mainView.addSubview(titleLabel)
        mainView.addSubview(emailField)
        mainView.addSubview(passwordField)
        mainView.addSubview(buttonGo)
        mainView.addSubview(buttonRegistration)
        
        mainView.snp.makeConstraints { (make) in
            make.top.leftMargin.rightMargin.bottom.equalToSuperview()
        }
        
        imageLogin.snp.makeConstraints { (make) in
            make.topMargin.equalTo(mainView.snp.topMargin).inset(16)
            make.leftMargin.equalTo(mainView.snp.leftMargin).inset(16)
            make.rightMargin.equalTo(mainView.snp.rightMargin).inset(16)
            make.height.width.equalTo(180)
            make.centerX.equalTo(mainView)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.topMargin.equalTo(imageLogin.snp.bottomMargin).offset(16)
            make.leftMargin.equalTo(mainView.snp.leftMargin).inset(16)
            make.rightMargin.equalTo(mainView.snp.rightMargin).inset(16)
            make.height.equalTo(50)
        }
        
        emailField.snp.makeConstraints { (make) in
            make.topMargin.equalTo(titleLabel.snp.bottom).offset(42)
            make.leftMargin.equalTo(mainView.snp.leftMargin).inset(16)
            make.rightMargin.equalTo(mainView.snp.rightMargin).inset(16)
            make.height.equalTo(52)
        }
        
        passwordField.snp.makeConstraints { (make) in
            make.topMargin.equalTo(emailField.snp.bottom).offset(22)
            make.leftMargin.equalTo(mainView.snp.leftMargin).inset(16)
            make.rightMargin.equalTo(mainView.snp.rightMargin).inset(16)
            make.height.equalTo(52)
        }
        
        buttonGo.snp.makeConstraints { (make) in
            make.topMargin.equalTo(passwordField.snp.bottom).offset(48)
            make.leftMargin.equalTo(mainView.snp.leftMargin).inset(16)
            make.rightMargin.equalTo(mainView.snp.rightMargin).inset(16)
            make.bottomMargin.equalTo(buttonRegistration.snp.bottomMargin).inset(16)
            make.height.equalTo(52)
        }
        
        buttonRegistration.snp.makeConstraints { (make) in
            make.topMargin.equalTo(buttonGo.snp.bottom).offset(22)
            make.leftMargin.equalTo(mainView.snp.leftMargin).inset(16)
            make.rightMargin.equalTo(mainView.snp.rightMargin).inset(16)
            make.bottomMargin.equalTo(mainView.snp.bottomMargin).inset(16)
            make.height.equalTo(52)
        }

        
        buttonGo.addTarget(self, action: #selector(signin), for: .touchUpInside)
    }

    @objc
    func signin() {
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty  else {
            print("missing filed data")
            let alert = UIAlertController(title: "Atenção!", message: "Os campos e-mail e password são obrigatórios!", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self] result, error in
            guard let strongSelf = self else { return }
            
            guard error == nil else {
                print("Without registration")
                let alert = UIAlertController(title: "Desculpe!", message: "Você ainda não tem um registro, para entrar no app, por favor crie ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                return
            }
        })
    }
}
