//
//  CodeView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 28/01/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

public protocol CodeView {
    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()
}

extension CodeView {
    public func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }

    public func setupAdditionalConfiguration() {}
}
