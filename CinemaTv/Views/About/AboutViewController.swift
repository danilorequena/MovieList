////
////  AboutView.swift
////  CinemaTv
////
////  Created by Danilo Requena on 01/01/21.
////  Copyright © 2021 Danilo Requena. All rights reserved.
////
//
//import Foundation
//import UIKit
//import SnapKit
//
//final class AboutViewController: UIViewController, Storyboaded {
//    
//    private let mainView: UIView = {
//       let view = UIView()
//        view.backgroundColor = UIColor(named: "mainColor")
//        
//        return view
//    }()
//    
//    private let aboutView: UIView = {
//       let view = UIView()
//        view.backgroundColor = #colorLiteral(red: 0.2555171847, green: 0.2747665644, blue: 0.300489068, alpha: 1)
//        view.layer.cornerRadius = 10
//        
//        return view
//    }()
//    
//    private var titleLabel: UILabel = {
//       let label = UILabel()
//        label.textColor = .white
//        label.text = "About"
//        label.font = .boldSystemFont(ofSize: 22)
//        
//        return label
//    }()
//    
//    private var aboutLabel: UILabel = {
//       let label = UILabel()
//        label.textColor = .white
//        label.numberOfLines = 0
//        label.text = "about_message".localized
//        
//        return label
//    }()
//    
//    private let closeButton: UIButton = {
//       let button = UIButton()
//        button.setTitle("Ok", for: .normal)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = .gray
//        button.layer.cornerRadius = 10
//        button.addTarget(self, action: #selector(tappedCloseButton), for: UIControl.Event.touchUpInside)
//        
//        return button
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupLayout()
//    }
//    
//    private func setupLayout() {
//        view.addSubview(mainView)
//        mainView.addSubview(titleLabel)
//        mainView.addSubview(aboutView)
//        aboutView.addSubview(aboutLabel)
//        mainView.addSubview(closeButton)
//        
//        mainView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview().inset(8)
//        }
//        
//        titleLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(mainView.snp.top).inset(16)
//            make.left.right.equalTo(mainView).inset(16)
//        }
//        
//        aboutView.snp.makeConstraints { (make) in
//            make.topMargin.equalTo(titleLabel).offset(40)
//            make.leading.equalTo(mainView).offset(20)
//            make.trailing.equalTo(mainView).inset(20)
//            
//        }
//        
//        aboutLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(20)
//            make.trailingMargin.leftMargin.equalTo(aboutView).inset(20)
//        }
//        
//        closeButton.snp.makeConstraints { (make) in
//            make.topMargin.equalTo(aboutView.snp.bottom).offset(20)
//            make.leftMargin.equalTo(aboutView)
//            make.rightMargin.equalTo(aboutView)
//            make.bottomMargin.equalTo(mainView).inset(20)
//            make.height.equalTo(60)
//        }
//    }
//    
//    @objc private func tappedCloseButton(sender: UIButton) {
//        self.dismiss(animated: true, completion: nil)
//    }
//}
