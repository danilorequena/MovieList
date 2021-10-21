//
//  EmptyStateView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 20/10/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import Foundation
import UIKit

final class EmptyStateView: UIView {
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.2)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let emptyLabel = UILabel.Factory.build(
        text: "Digite o filme desejado",
        textAlignment: .left,
        textStyle: .body,
        numberOfLines: 0,
        accessibilityIdentifier: "emptyLabel",
        textColor: .white
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyStateView: CodeView {
    func buildViewHierarchy() {
        addSubview(emptyView)
        emptyView.addSubview(emptyLabel)
    }
    
    func setupConstraints() {
        emptyView.anchor(height: 220)
        emptyView.anchorCenterYToSuperview()
        emptyView.anchor(
            leading: leadingAnchor,
            trailing: trailingAnchor,
            insets: .init(inset: 22)
        )
        
        emptyLabel.anchorCenterTo(view: emptyView)
    }
}
