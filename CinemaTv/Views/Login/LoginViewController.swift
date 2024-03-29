//
//  LoginViewController.swift
//  CinemaTv
//
//  Created by Danilo Requena on 18/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth


final class LoginViewController: UIViewController, Storyboaded {
    weak var coordinator: MainCoordinator?
    
    private lazy var loginView: LoginView = {
       let view = LoginView()
        view.delegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func loadView() {
        view = loginView
        view.accessibilityIdentifier = "registrationViewController"
        loginView.accessibilityIdentifier = "registrationView"
    }
}

extension LoginViewController: LoginViewDelegate {
    func didTapLogin() {
        guard let email = loginView.emailField.text, !email.isEmpty,
              let password = loginView.passwordField.text, !password.isEmpty  else {
            print("missing failed data")
            let alert = UIAlertController(title: "Atenção!", message: "Os campos e-mail e password são obrigatórios!", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: {[weak self] result, error in
            guard error == nil else {
                print("Without registration")
                let alert = UIAlertController(title: "Desculpe!", message: "Você ainda não tem um registro, para entrar no app, por favor crie o seu registro ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { (action) in
                    self?.navigationController?.pushViewController(RegistrationViewController(), animated: true)
                }))
                self?.present(alert, animated: true, completion: nil)
                return
            }
            print("You have signed in")
            self?.coordinator?.userLogged()
        })
    }
    
    func didTapGoToRegistration() {
        let vc = RegistrationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
