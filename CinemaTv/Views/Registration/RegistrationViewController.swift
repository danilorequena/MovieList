//
//  RegistrationViewController.swift
//  CinemaTv
//
//  Created by Danilo Requena on 28/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

final class RegistrationViewController: UIViewController {
    
    private lazy var registrationView: RegistrationView = {
        let view = RegistrationView()
        view.delegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func loadView() {
        view = registrationView
        view.accessibilityIdentifier = "registrationViewController"
        registrationView.accessibilityIdentifier = "registrationView"
    }
}

extension RegistrationViewController: RegistrationViewDelegate {
    func didTapRegister() {
        guard let email = registrationView.emailField.text, !email.isEmpty,
              let password = registrationView.passwordField.text, !password.isEmpty  else {
            print("missing filed data")
            let alert = UIAlertController(title: "Atenção!", message: "Os campos e-mail e password são obrigatórios!", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
            
            guard self != nil else {
                return
            }
            
            guard error == nil else {
                // show account creation
                print("Account creation failed")
                let alert = UIAlertController(title: "Desculpe!", message: "Algo falhou, por favor tente novamente.", preferredStyle: .alert)
                alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
                self?.present(alert, animated: true, completion: nil)
                return
            }
            
            print("You have signed in")
            let alert = UIAlertController(title: "Sucesso!", message: "Seu login foi criado, agora você já pode se entrar no app.", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: { (action) in
                self?.navigationController?.popViewController(animated: true)
            }))
            self?.present(alert, animated: true, completion: nil)
        })
                                           
    }
}
