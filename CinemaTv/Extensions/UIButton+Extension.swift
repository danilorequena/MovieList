//
//  UIButton+Extension.swift
//  CinemaTv
//
//  Created by Danilo Requena on 21/04/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

extension UIButton {
    public enum Factory {
        public static func build(
            title: String? = nil,
            titleColor: UIColor = .black,
            contentHorizontalAlignment: UIControl.ContentHorizontalAlignment = .center,
            image: UIImage? = nil,
            backgroundColor: UIColor = .clear,
            cornerRadius: CGFloat = 0,
            borderColor: CGColor = UIColor.clear.cgColor,
            borderWidth: CGFloat = 0.0,
            textStyle: UIFont.TextStyle = .headline,
            accessibilityIdentifier: String
        ) -> UIButton {
            let button = UIButton(frame: .zero)
            button.setTitle(title, for: .normal)
            button.setTitleColor(titleColor, for: .normal)
            button.setImage(image, for: .normal)
            button.backgroundColor = backgroundColor
            button.layer.cornerRadius = cornerRadius
            button.tintColor = titleColor
            button.titleLabel?.font = .systemFont(ofSize: 12)
            button.accessibilityIdentifier = accessibilityIdentifier
            button.contentHorizontalAlignment = contentHorizontalAlignment
            button.layer.borderColor = borderColor
            button.layer.borderWidth = borderWidth

            return button
        }
    }

    public func underlineTitle() {
        guard let title = titleLabel else { return }
        guard let tittleText = title.text else { return }
        let textRange = NSRange(location: 0, length: tittleText.count)

        let attributedString = NSMutableAttributedString(string: tittleText)
        attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)

        setAttributedTitle(attributedString, for: .normal)
    }
}

