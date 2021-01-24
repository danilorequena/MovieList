//
//  LoginViewModel.swift
//  CinemaTv
//
//  Created by Danilo Requena on 24/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import FirebaseAuth

protocol LoginProtocol: AnyObject {
    func signin(buttonLogin: UIButton, user: String, password: String)
    func signout()
}

final class LoginViewModel: LoginProtocol {
    func signin(buttonLogin: UIButton, user: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: user, password: password, completion: {[weak self] result, error in
            guard let strongSelf = self else { return }
            
            guard error == nil else {
                print("Without registration") 
                return
            }
        })
    }
    
    func signout() {}
    
    func createUser() {
//        FirebaseAuth.Auth.auth().createUser(withEmail: user, password: password) { (result, error) in
//            guard error == nil else {
//                print("Account creation Failed") // TODO: - Tratar com um alert
//                return
//            }
//        }
    }
    
    @objc
    func signin(user: String, password: String, present: UIViewController) {
        FirebaseAuth.Auth.auth().signIn(withEmail: user, password: password, completion: {[weak self] result, error in
            guard let strongSelf = self else { return }
            
            guard error == nil else {
                print("Without registration")
                let alert = UIAlertController(title: "Desculpe!", message: "Você ainda não tem um registro, para entrar no app, por favor crie o seu registro.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                present.present(alert, animated: true, completion: nil)
                return
            }
        })
    }
    
    
}
