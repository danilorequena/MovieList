//
//  LoginViewModel.swift
//  CinemaTv
//
//  Created by Danilo Requena on 24/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import FirebaseAuth
import UIKit

protocol LoginProtocol: AnyObject {
    func signin(buttonLogin: UIButton, user: String, password: String)
    func signout()
}

final class LoginViewModel: LoginProtocol {
    func signin(buttonLogin: UIButton, user: String, password: String) {
        FirebaseAuth.Auth.auth().signIn(withEmail: user, password: password, completion: {[weak self] result, error in
            guard self != nil else { return }
            
            guard error == nil else {
                print("Without registration") 
                return
            }
        })
    }
    
    func signout() {}
    
    @objc
    func signin(user: String, password: String, present: UIViewController) {
        FirebaseAuth.Auth.auth().signIn(withEmail: user, password: password, completion: {[weak self] result, error in
            guard self != nil else { return }
            
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
