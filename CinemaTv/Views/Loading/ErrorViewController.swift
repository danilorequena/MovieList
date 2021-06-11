//
//  LoadView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 17/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class ErrorViewController: UIViewController, Storyboaded {
    weak var coordinator: MainCoordinator?
    
    private let image: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "error")
        image.sizeToFit()
        return image
    }()
    
    private let buttonClose: UIButton = {
       let button = UIButton()
        button.setTitle("close", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    @objc
    private func close() {
//        dismiss(animated: true, completion: nil)
        
    }
}

extension ErrorViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubviews(image, buttonClose)
    }
    
    func setupConstraints() {
        image.anchorCenterSuperview()
        image.anchor(height: 100, width: 150)
        buttonClose.anchor(
            leading: view.leadingAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            trailing: view.trailingAnchor,
            insets: .init(top: 0, left: 8, bottom: 16, right: 8)
        )
        buttonClose.anchor(height: 52)
    }
    
    
}
