//
//  RegistrationViewController.swift
//  CinemaTv
//
//  Created by Danilo Requena on 28/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

final class RegistrationViewController: UIViewController {
    
    private let registrationView: RegistrationView = {
        let view = RegistrationView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navigationController?.navigationBar.isHidden = false
        setupView()
    }
}

extension RegistrationViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(registrationView)
    }
    
    func setupConstraints() {
        registrationView.bindFrameToSuperviewBounds()
    }
    
    
}
