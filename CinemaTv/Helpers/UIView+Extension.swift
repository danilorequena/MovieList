//
//  UIView+Extension.swift
//  ToDoMovie&Series
//
//  Created by Danilo Requena on 07/09/20.
//  Copyright © 2020 Danilo Requena. All rights reserved.
//

import UIKit

extension UIView {
    func shadowDefault() {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.1
    }
    
    public typealias NSLayoutDimensionHeightAndWidth = (NSLayoutConstraint?, NSLayoutConstraint?)
    public typealias NSLayoutConstraintXAndY = (NSLayoutConstraint?, NSLayoutConstraint?)

        @discardableResult
        public func anchorTopGreaterThanOrEqualTo(constant: CGFloat,
                                                  to anchor: NSLayoutYAxisAnchor,
                                                  priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let topConstraint: NSLayoutConstraint? = topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            topConstraint?.priority = priority
            topConstraint?.isActive = true

            return topConstraint
        }

        @discardableResult
        public func anchorTopLessThanOrEqualTo(constant: CGFloat,
                                               to anchor: NSLayoutYAxisAnchor,
                                               priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let topConstraint: NSLayoutConstraint? = topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            topConstraint?.priority = priority
            topConstraint?.isActive = true

            return topConstraint
        }

        @discardableResult
        public func anchorBottomGreaterThanOrEqualTo(constant: CGFloat,
                                                     to anchor: NSLayoutYAxisAnchor,
                                                     priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let topConstraint: NSLayoutConstraint? = bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -constant)
            topConstraint?.priority = priority
            topConstraint?.isActive = true

            return topConstraint
        }

        @discardableResult
        public func anchorHeightLessThanOrEqualTo(_ dimension: NSLayoutDimension, multiplier: CGFloat = 1.0) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let heightConstraint: NSLayoutConstraint? = heightAnchor.constraint(lessThanOrEqualTo: dimension, multiplier: multiplier)
            heightConstraint?.isActive = true

            return heightConstraint
        }

        @discardableResult
        public func anchorBottomLessThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,
                                                  constant: CGFloat = 0.0,
                                                  priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let bottomConstraint: NSLayoutConstraint? = bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant)
            bottomConstraint?.priority = priority
            bottomConstraint?.isActive = true

            return bottomConstraint
        }

        @discardableResult
        public func anchorLeadingLessThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                                                   constant: CGFloat = 0.0,
                                                   priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let leadingConstraint: NSLayoutConstraint? = leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
            leadingConstraint?.priority = priority
            leadingConstraint?.isActive = true

            return leadingConstraint
        }

        @discardableResult
        public func anchorLeadingGreaterThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                                                      constant: CGFloat = 0.0,
                                                      priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let leadingConstraint: NSLayoutConstraint? = leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
            leadingConstraint?.priority = priority
            leadingConstraint?.isActive = true

            return leadingConstraint
        }

        @discardableResult
        public func anchorTrailingLessThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                                                    constant: CGFloat = 0.0,
                                                    priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let trailingConstraint: NSLayoutConstraint? = trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: -constant)
            trailingConstraint?.priority = priority
            trailingConstraint?.isActive = true

            return trailingConstraint
        }

        @discardableResult
        public func anchorTrailingGreaterThanOrEqualTo(_ anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,
                                                       constant: CGFloat = 0.0,
                                                       priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let trailingConstraint: NSLayoutConstraint? = trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: -constant)
            trailingConstraint?.priority = priority
            trailingConstraint?.isActive = true

            return trailingConstraint
        }

        @discardableResult
        public func anchor(top: NSLayoutYAxisAnchor? = nil,
                           leading: NSLayoutXAxisAnchor? = nil,
                           bottom: NSLayoutYAxisAnchor? = nil,
                           trailing: NSLayoutXAxisAnchor? = nil,
                           priority: UILayoutPriority = .required,
                           insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
            translatesAutoresizingMaskIntoConstraints = false

            var anchors = [NSLayoutConstraint]()

            if let top = top {
                let constraint = topAnchor.constraint(equalTo: top, constant: insets.top)
                constraint.priority = priority
                anchors.append(constraint)
            }

            if let leading = leading {
                let constraint = leadingAnchor.constraint(equalTo: leading, constant: insets.left)
                constraint.priority = priority
                anchors.append(constraint)
            }

            if let bottom = bottom {
                let constraint = bottomAnchor.constraint(equalTo: bottom, constant: -insets.bottom)
                constraint.priority = priority
                anchors.append(constraint)
            }

            if let trailing = trailing {
                let constraint = trailingAnchor.constraint(equalTo: trailing, constant: -insets.right)
                constraint.priority = priority
                anchors.append(constraint)
            }

            NSLayoutConstraint.activate(anchors)

            return anchors
        }

        @discardableResult
        public func anchor(height: CGFloat? = nil,
                           width: CGFloat? = nil,
                           priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
            translatesAutoresizingMaskIntoConstraints = false

            var anchors = [NSLayoutConstraint]()

            if let width = width {
                let constraint = widthAnchor.constraint(equalToConstant: width)
                constraint.priority = priority
                anchors.append(constraint)
            }

            if let height = height {
                let constraint = heightAnchor.constraint(equalToConstant: height)
                constraint.priority = priority
                anchors.append(constraint)
            }

            NSLayoutConstraint.activate(anchors)

            return anchors
        }

        @discardableResult
        public func anchor(aspectRatio: CGFloat,
                           priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
            translatesAutoresizingMaskIntoConstraints = false

            var anchors = [NSLayoutConstraint]()

            let constraint = widthAnchor.constraint(equalTo: heightAnchor, multiplier: aspectRatio)
            constraint.priority = priority
            anchors.append(constraint)

            NSLayoutConstraint.activate(anchors)

            return anchors
        }

        @discardableResult
        public func anchor(heightAnchor: NSLayoutDimension? = nil,
                           heightMultiplier: CGFloat = 1,
                           widthAnchor: NSLayoutDimension? = nil,
                           widthMultiplier: CGFloat = 1) -> NSLayoutDimensionHeightAndWidth {
            translatesAutoresizingMaskIntoConstraints = false

            var heightConstraint: NSLayoutConstraint?
            var widthConstraint: NSLayoutConstraint?

            if let heightAnchor = heightAnchor {
                heightConstraint = self.heightAnchor.constraint(equalTo: heightAnchor, multiplier: heightMultiplier)
                heightConstraint?.isActive = true
            }

            if let widthAnchor = widthAnchor {
                widthConstraint = self.widthAnchor.constraint(equalTo: widthAnchor, multiplier: widthMultiplier)
                widthConstraint?.isActive = true
            }

            return (heightConstraint, widthConstraint)
        }

        @discardableResult
        public func anchorLessThanOrEqualTo(heightAnchor: NSLayoutDimension? = nil,
                                            heightMultiplier: CGFloat = 1,
                                            widthAnchor: NSLayoutDimension? = nil,
                                            widthMultiplier: CGFloat = 1) -> NSLayoutDimensionHeightAndWidth {
            translatesAutoresizingMaskIntoConstraints = false

            var heightConstraint: NSLayoutConstraint?
            var widthConstraint: NSLayoutConstraint?

            if let heightAnchor = heightAnchor {
                heightConstraint = self.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: heightMultiplier)
                heightConstraint?.isActive = true
            }

            if let widthAnchor = widthAnchor {
                widthConstraint = self.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, multiplier: widthMultiplier)
                widthConstraint?.isActive = true
            }

            return (heightConstraint, widthConstraint)
        }

        @discardableResult
        public func anchorGreaterThanOrEqualTo(heightAnchor: NSLayoutDimension? = nil,
                                               heightConstant: CGFloat = 0,
                                               widthAnchor: NSLayoutDimension? = nil,
                                               widthConstant: CGFloat = 0) -> NSLayoutDimensionHeightAndWidth {
            translatesAutoresizingMaskIntoConstraints = false

            var heightConstraint: NSLayoutConstraint?
            var widthConstraint: NSLayoutConstraint?

            if let heightAnchor = heightAnchor {
                heightConstraint = self.heightAnchor.constraint(greaterThanOrEqualTo: heightAnchor,
                                                                multiplier: 1,
                                                                constant: heightConstant)
                heightConstraint?.isActive = true
            }

            if let widthAnchor = widthAnchor {
                widthConstraint = self.widthAnchor.constraint(greaterThanOrEqualTo: widthAnchor,
                                                              multiplier: 1,
                                                              constant: widthConstant)
                widthConstraint?.isActive = true
            }

            return (heightConstraint, widthConstraint)
        }

        @discardableResult
        public func anchorHeightGreaterThanOrEqualTo(constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
            translatesAutoresizingMaskIntoConstraints = false

            let anchor = heightAnchor.constraint(greaterThanOrEqualToConstant: constant)
            anchor.priority = priority
            anchor.isActive = true

            return anchor
        }

        @discardableResult
        public func anchorSameWidthAsSuperview(multiplier: CGFloat = 1.0) -> NSLayoutConstraint? {
            guard let superview = superview else { return nil }
            return anchorSameWidth(as: superview, multiplier: multiplier)
        }

        @discardableResult
        public func anchorSameHeightAsSuperview(multiplier: CGFloat = 1.0) -> NSLayoutConstraint? {
            guard let superview = superview else { return nil }
            return anchorSameHeight(as: superview, multiplier: multiplier)
        }

        @discardableResult
        public func anchorSameWidth(as view: UIView, multiplier: CGFloat = 1.0) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let widthConstraint: NSLayoutConstraint? = widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier)
            widthConstraint?.isActive = true

            return widthConstraint
        }

        @discardableResult
        public func anchorSameHeight(as view: UIView, multiplier: CGFloat = 1.0) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            let heightConstraint: NSLayoutConstraint? = heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: multiplier)
            heightConstraint?.isActive = true

            return heightConstraint
        }

        @discardableResult
        public func anchorCenterXToSuperview(constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            if let centerXAnchor = superview?.centerXAnchor {
                let anchor = self.centerXAnchor.constraint(equalTo: centerXAnchor, constant: constant)
                anchor.priority = priority
                anchor.isActive = true
                return anchor
            }

            return nil
        }

        @discardableResult
        public func anchorCenterXTo(view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
            translatesAutoresizingMaskIntoConstraints = false

            let anchor = centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant)
            anchor.priority = priority
            anchor.isActive = true

            return anchor
        }

        @discardableResult
        public func anchorCenterYTo(view: UIView, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
            translatesAutoresizingMaskIntoConstraints = false

            let anchor = centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant)
            anchor.priority = priority
            anchor.isActive = true

            return anchor
        }

        @discardableResult
        public func anchorCenterYToSuperview(constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint? {
            translatesAutoresizingMaskIntoConstraints = false

            if let centerYAnchor = superview?.centerYAnchor {
                let anchor = self.centerYAnchor.constraint(equalTo: centerYAnchor, constant: constant)
                anchor.priority = priority
                anchor.isActive = true
                return anchor
            }

            return nil
        }

        @discardableResult
        public func anchorCenterTo(view: UIView, priority: UILayoutPriority = .required) -> NSLayoutConstraintXAndY {
            let centerXConstraint = anchorCenterXTo(view: view, priority: priority)
            let centerYConstraint = anchorCenterYTo(view: view, priority: priority)
            return (centerXConstraint, centerYConstraint)
        }

        @discardableResult
        public func anchorCenterSuperview(priority: UILayoutPriority = .required) -> NSLayoutConstraintXAndY {
            let centerXAnchor = anchorCenterXToSuperview(priority: priority)
            let centerYAnchor = anchorCenterYToSuperview(priority: priority)

            return (centerXAnchor, centerYAnchor)
        }

        public func bindFrameToSuperviewBounds(insets: UIEdgeInsets = .zero) {
            guard let superview = self.superview else { return }
            anchor(top: superview.topAnchor,
                   leading: superview.leadingAnchor,
                   bottom: superview.bottomAnchor,
                   trailing: superview.trailingAnchor, insets: insets)
        }

        public func bindFrameToSuperviewSafeBounds(insets: UIEdgeInsets = .zero) {
            guard let superview = self.superview else { return }
            anchor(top: superview.safeAreaLayoutGuide.topAnchor,
                   leading: superview.safeAreaLayoutGuide.leadingAnchor,
                   bottom: superview.safeAreaLayoutGuide.bottomAnchor,
                   trailing: superview.safeAreaLayoutGuide.trailingAnchor, insets: insets)
        }

        public func anchor(to view: UIView, insets: UIEdgeInsets = .zero) {
            anchor(top: view.topAnchor,
                   leading: view.leadingAnchor,
                   bottom: view.bottomAnchor,
                   trailing: view.trailingAnchor,
                   insets: insets)
        }

        public func addSubviews(_ views: UIView...) {
            views.forEach { addSubview($0) }
        }
    

}
