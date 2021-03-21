//
//  UIImageView+Extension.swift
//  CinemaTv
//
//  Created by Danilo Requena on 14/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    public enum Factory {
        public static func build(
            image: UIImage? = nil,
            contentMode: UIView.ContentMode = .scaleAspectFit,
            backgroundColor: UIColor = .clear,
            tintColor: UIColor = .white,
            accessibilityIdentifier: String
        ) -> UIImageView {
            let imageView = UIImageView(image: image)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = contentMode
            imageView.backgroundColor = backgroundColor
            imageView.tintColor = tintColor
            imageView.accessibilityIdentifier = accessibilityIdentifier
            return imageView
        }
    }

    public func addImageTransparency() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.0).cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor
        ]
        gradientLayer.locations = [0.21, 1]
        gradientLayer.bounds = CGRect(
            x: 0,
            y: 0,
            width: bounds.width,
            height: bounds.height / 2
        ).insetBy(dx: -0.5 * bounds.size.width, dy: -0.5 * bounds.size.height)
        gradientLayer.position = center
        layer.addSublayer(gradientLayer)
    }
    
    public func download(from url: String, placeHolder: UIImage? = nil) {
        download(from: URL(string: url), placeHolder: placeHolder)
    }

    public func download(from url: String?, placeHolder: UIImage? = nil) {
        guard let url = url else { return }
        download(from: URL(string: url), placeHolder: placeHolder)
    }

    public func download(from url: String, placeHolder: UIImage? = nil, completion: @escaping (Bool) -> Void) {
        image = placeHolder

        guard let url = URL(string: url) else {
            return
        }

        kf.setImage(with: url, placeholder: placeHolder, completionHandler: { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        })
    }

    public func download(from url: URL?, placeHolder: UIImage? = nil) {
        image = placeHolder

        if let url = url {
            kf.setImage(with: url, placeholder: placeHolder)
        }
    }
}
