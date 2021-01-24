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
import SnapKit


final class LoginViewController: UIViewController, Storyboaded {
    private let loginView = LoginView()
    weak var coordinator: MainCoordinator?
    
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel = LoginViewModel()
        navigationController?.navigationBar.isHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    private func setupView() {
        view.addSubview(loginView)
        
        loginView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func signin() {
        
    }
}
