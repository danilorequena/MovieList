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
    private let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.addSubview(loginView)
    }
}
