//
//  HeaderView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 14/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

final class HeaderView: UICollectionReusableView {
    
    public var titleText: String? {
        get { headerTitle.text }
        set { headerTitle.text = newValue }
    }
    
    public var titleColor: UIColor {
        get { headerTitle.tintColor}
        set { headerTitle.tintColor = newValue }
    }
    
    private let headerTitle = UILabel.Factory.build(
        textAlignment: .left,
        textStyle: .title1,
        numberOfLines: 1,
        accessibilityIdentifier: "",
        textColor: .white,
        minimumScaleFactor: 12
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderView: CodeView {
    func buildViewHierarchy() {
        addSubview(headerTitle)
    }
    
    func setupConstraints() {
        headerTitle.anchor(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            insets: .init(top: 8, left: 8, bottom: 0, right: 8)
        )
    }
    
    
}
