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
    private let mainView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return view
    }()
    
    private let stack: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillProportionally
        
        return stackView
    }()
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "loginTitle")
        image.sizeToFit()
        return image
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font = UIFont.systemFont(ofSize: 27)
        label.textAlignment = .center
        label.textColor = .white
        
       return label
    }()
    
    private let emailField: UITextField = {
       let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(
            string: "e-mail",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        )
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
        textField.attributedPlaceholder = NSAttributedString(
            string: "password",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray]
        )
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
    
    private let buttonRegistration: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1)
         button.setTitleColor(.white, for: .normal)
         button.setTitle("register", for: .normal)
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
        let arrangedViews = [titleLabel, emailField, passwordField, buttonRegistration]
        addSubview(mainView)
        mainView.addSubview(image)
        mainView.addSubview(stack)
        arrangedViews.forEach(stack.addArrangedSubview)
    }
    
    func setupConstraints() {
        mainView.bindFrameToSuperviewSafeBounds()
        image.anchor(height: 180, width: 180)
        image.anchorCenterXTo(view: stack)
        stack.anchor(
            top: image.bottomAnchor,
            leading: mainView.leadingAnchor,
            trailing: mainView.trailingAnchor,
            insets: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        titleLabel.anchor(height: 50, width: 50)
        emailField.anchor(height: 52)
        passwordField.anchor(height: 52)
        buttonRegistration.anchor(height: 52)
        
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    
}
