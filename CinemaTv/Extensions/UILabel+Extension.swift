//
//  UILabel+Extension.swift
//  CinemaTv
//
//  Created by Danilo Requena on 14/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

public enum UILabelImagePosition {
    case left, right
}

extension UILabel {
    public enum Factory {
        public static func build(text: String? = nil,
                                 textAlignment: NSTextAlignment = .left,
                                 textStyle: UIFont.TextStyle = .body,
                                 numberOfLines: Int = 1,
                                 accessibilityIdentifier: String,
                                 textColor: UIColor,
                                 adjustsFontSizeToFitWidth: Bool = false,
                                 minimumScaleFactor: CGFloat = 0) -> UILabel {
            let label = UILabel(frame: .zero)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textAlignment = textAlignment

            label.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
            label.minimumScaleFactor = minimumScaleFactor

//            label.font = .scaledFont(textStyle)
            label.numberOfLines = numberOfLines
            label.adjustsFontForContentSizeCategory = true
            label.textColor = textColor
            label.accessibilityIdentifier = accessibilityIdentifier
            label.text = text
            return label
        }
    }

    public func addImage(
        _ image: UIImage,
        with color: UIColor,
        blankSpace: Bool = false,
        bounds: CGRect? = nil,
        on position: UILabelImagePosition
    ) {
        let text = self.text?.trimmingCharacters(in: CharacterSet.alphanumerics.inverted) ?? ""

        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image.tint(with: color)

        if let bounds = bounds {
            imageAttachment.bounds = bounds
        }

        let imageString = NSMutableAttributedString(attachment: imageAttachment)

        if blankSpace {
            imageString.append(NSMutableAttributedString(string: "  "))
        }

        let fullString = NSMutableAttributedString(string: text)
        if position == .left {
            fullString.insert(imageString, at: 0)
        } else {
            fullString.append(imageString)
        }

        attributedText = fullString
    }

    public func applyBoldFont(at range: NSRange) {
        guard let string = text else { return }
        let boldFont: UIFont = .boldSystemFont(ofSize: 22)
        let boldAttribute = [NSAttributedString.Key.font: boldFont]
        let attrStr = NSMutableAttributedString(string: string, attributes: [:])
        attrStr.setAttributes(boldAttribute, range: range)
        attributedText = attrStr
    }

    public func applyColor(at range: NSRange, color: UIColor) {
        guard let string = text else { return }
        let colorAttributes = [NSAttributedString.Key.foregroundColor: color]
        let attrStr = NSMutableAttributedString(string: string, attributes: [:])
        attrStr.setAttributes(colorAttributes, range: range)
        attributedText = attrStr
    }

    public func applyBoldFont() {
        guard let text = text else { return }
        applyBoldFont(at: NSRange(location: 0, length: text.count))
    }
}

