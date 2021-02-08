//
//  CinemaTvCollectionViewDataSource.swift
//  CinemaTv
//
//  Created by Danilo Requena on 07/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

public protocol Section {
    func numberOfItemsInSection() -> Int
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath)
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool
    func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    )
    func register(_ collectionView: UICollectionView)
    func cellSize(with collectionViewBounds: CGRect, at indexPath: IndexPath) -> CGSize
    func headerSize(width: CGFloat, in section: Int) -> CGSize
    func headerInsets(in section: Int) -> UIEdgeInsets
    func footerSize(width: CGFloat, in section: Int) -> CGSize
    func animateOnTouch(at indexPath: IndexPath) -> Bool
}

extension Section {
    public func animateOnTouch(at _: IndexPath) -> Bool {
        return true
    }

    public func collectionView(_: UICollectionView,
                               viewForSupplementaryElementOfKind _: String,
                               at _: IndexPath) -> UICollectionReusableView {
        return UICollectionReusableView()
    }

    public func collectionView(_: UICollectionView, didSelectItemAt _: IndexPath) {}

    public func collectionView(_: UICollectionView, didDeselectItemAt _: IndexPath) {}

    public func collectionView(_: UICollectionView, shouldSelectItemAt _: IndexPath) -> Bool {
        return true
    }

    public func collectionView(
        _: UICollectionView,
        willDisplay _: UICollectionViewCell,
        forItemAt _: IndexPath
    ) {}

    public func collectionView(_: UICollectionView, shouldDeselectItemAt _: IndexPath) -> Bool {
        return true
    }

    public func footerSize(width _: CGFloat, in _: Int) -> CGSize {
        return .zero
    }
}

public protocol BrMCollectionViewDataSourceProtocol: AnyObject {
    func scrollViewDidScroll(_ scrollView: UIScrollView)
}

public class BrMCollectionViewDataSource: NSObject,
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    public weak var collectionViewDataSource: BrMCollectionViewDataSourceProtocol?

    var sections: [Section]

    public init(sections: [Section]) {
        self.sections = sections
    }

    public func animateOnTouch(at indexPath: IndexPath) -> Bool {
        return sections[indexPath.section].animateOnTouch(at: indexPath)
    }

    public func numberOfSections(in _: UICollectionView) -> Int {
        return sections.count
    }

    public func collectionView(_: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].numberOfItemsInSection()
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return sections[indexPath.section].collectionView(collectionView, cellForItemAt: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        sections[indexPath.section].collectionView(collectionView, willDisplay: cell, forItemAt: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        sections[indexPath.section].collectionView(collectionView, didSelectItemAt: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        sections[indexPath.section].collectionView(collectionView, didDeselectItemAt: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        sections[indexPath.section].collectionView(collectionView, shouldSelectItemAt: indexPath)
    }

    public func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        sections[indexPath.section].collectionView(collectionView, shouldDeselectItemAt: indexPath)
    }

    // Altura das headers
    public func collectionView(_ collectionView: UICollectionView,
                               layout _: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        return sections[section].headerSize(width: collectionView.bounds.width, in: section)
    }

    // Altura dos Footers
    public func collectionView(_ collectionView: UICollectionView,
                               layout _: UICollectionViewLayout,
                               referenceSizeForFooterInSection section: Int) -> CGSize {
        return sections[section].footerSize(width: collectionView.bounds.width, in: section)
    }

    // Altura das celulas
    public func collectionView(_ collectionView: UICollectionView,
                               layout _: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sections[indexPath.section].cellSize(with: collectionView.bounds, at: indexPath)
    }

    // UIEdgeInsets das sections
    public func collectionView(_: UICollectionView,
                               layout _: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return sections[section].headerInsets(in: section)
    }

    // UICollectionReusableView
    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        return sections[indexPath.section].collectionView(collectionView, viewForSupplementaryElementOfKind: kind, at: indexPath)
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionViewDataSource?.scrollViewDidScroll(scrollView)
    }
}

// Animation on touch
extension BrMCollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if !animateOnTouch(at: indexPath) { return }
        UIView.animate(withDuration: 0.25) {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.contentView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if !animateOnTouch(at: indexPath) { return }
        UIView.animate(withDuration: 0.25) {
            let cell = collectionView.cellForItem(at: indexPath)
            cell?.contentView.transform = CGAffineTransform.identity
        }
    }
}

