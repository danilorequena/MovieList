//
//  CinemaTvCollectionView.swift
//  CinemaTv
//
//  Created by Danilo Requena on 13/02/21.
//  Copyright © 2021 Danilo Requena. All rights reserved.
//

import UIKit

public final class CinemaTvCollectionView: UIView {
    // MARK: - Getters

    public var indexPathsForSelectedItems: [IndexPath]? {
        collectionView.indexPathsForSelectedItems
    }

    public var visibleCells: [UICollectionViewCell] {
        collectionView.visibleCells
    }

    // MARK: - Getters / Setters

    public override var clipsToBounds: Bool {
        get { collectionView.clipsToBounds }
        set {
            super.clipsToBounds = newValue
            collectionView.clipsToBounds = newValue
        }
    }

    public var contentOffset: CGPoint {
        get { collectionView.contentOffset }
        set { collectionView.contentOffset = newValue }
    }

    public var refreshControl: UIRefreshControl? {
        get { collectionView.refreshControl }
        set { collectionView.refreshControl = newValue }
    }

    public var isScrollEnabled: Bool {
        get { collectionView.isScrollEnabled }
        set { collectionView.isScrollEnabled = newValue }
    }

    public var isPagingEnabled: Bool {
        get { collectionView.isPagingEnabled }
        set { collectionView.isPagingEnabled = newValue }
    }

    public var bounces: Bool {
        get { collectionView.bounces }
        set { collectionView.bounces = newValue }
    }

    public var estimatedItemSize: CGSize {
        get { flowLayout.estimatedItemSize }
        set { flowLayout.estimatedItemSize = newValue }
    }

    public var allowsMultipleSelection: Bool {
        get { collectionView.allowsMultipleSelection }
        set { collectionView.allowsMultipleSelection = newValue }
    }

    public var showsHorizontalScrollIndicator: Bool {
        get { collectionView.showsHorizontalScrollIndicator }
        set { collectionView.showsHorizontalScrollIndicator = newValue }
    }

    public var showsVerticalScrollIndicator: Bool {
        get { collectionView.showsVerticalScrollIndicator }
        set { collectionView.showsVerticalScrollIndicator = newValue }
    }

    public var contentInset: UIEdgeInsets {
        get { collectionView.contentInset }
        set { collectionView.contentInset = newValue }
    }

    public var contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior {
        get { collectionView.contentInsetAdjustmentBehavior }
        set { collectionView.contentInsetAdjustmentBehavior = newValue }
    }

    // MARK: - Properties

    public let flowLayout: UICollectionViewFlowLayout

    public var scrollDirection: UICollectionView.ScrollDirection = .vertical {
        didSet {
            flowLayout.scrollDirection = scrollDirection
            let isVertical = (scrollDirection == .vertical)
            collectionView.showsHorizontalScrollIndicator = false
            collectionView.showsVerticalScrollIndicator = false
            collectionView.alwaysBounceVertical = isVertical
            collectionView.alwaysBounceHorizontal = !isVertical
            collectionView.allowsSelection = true
        }
    }

    private let dataSource: CinemaTvCollectionViewDataSource
    private var sections: [Section]

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.accessibilityIdentifier = "brMCollectionView"
        collectionView.keyboardDismissMode = .onDrag
        collectionView.allowsMultipleSelection = false
        return collectionView
    }()

    // MARK: - Initializer

    public init(
        sections: [Section],
        contentInset: UIEdgeInsets = .zero,
        flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout(),
        minimumCellSpacing: CGFloat = 25,
        minimumInterItemSpacing: CGFloat = 16
    ) {
        self.sections = sections
        self.flowLayout = flowLayout
        self.flowLayout.minimumInteritemSpacing = minimumInterItemSpacing
        self.flowLayout.minimumLineSpacing = minimumCellSpacing
        dataSource = CinemaTvCollectionViewDataSource(sections: sections)
        super.init(frame: .zero)
        setupView()
        collectionView.delegate = dataSource
        collectionView.dataSource = dataSource

        self.contentInset = contentInset
        sections.forEach { section in
            section.register(collectionView)
        }
    }

    @available(*, unavailable)
    public required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions

    public func update(sections: [Section]) {
        self.sections = sections
        dataSource.sections = sections

        sections.forEach { section in
            section.register(collectionView)
        }

        collectionView.reloadData()
    }

    public func selectItem(
        at indexPath: IndexPath,
        animated: Bool = false,
        scrollPosition: UICollectionView.ScrollPosition
    ) {
        collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: scrollPosition)
    }

    public func deselectItem(at indexPath: IndexPath, animated: Bool = false) {
        collectionView.deselectItem(at: indexPath, animated: animated)
    }

    public func setIdentifier(_ accessibilityIdentifier: String) {
        collectionView.accessibilityIdentifier = accessibilityIdentifier
    }

    public func setBackground(_ color: UIColor) {
        backgroundColor = color
        collectionView.backgroundColor = color
    }

    public func setBackground(view: UIView) {
        collectionView.backgroundView = view
    }

    public func setDataSourceProtocol(_ collectionViewDataSource: CinemaTvCollectionViewDataSourceProtocol) {
        dataSource.collectionViewDataSource = collectionViewDataSource
    }

    public func getNumberOfItems(inSection section: Int) -> Int {
        collectionView.numberOfItems(inSection: section)
    }
}

// MARK: - CodeView -

extension CinemaTvCollectionView: CodeView {
    public func buildViewHierarchy() {
        addSubview(collectionView)
    }

    public func setupConstraints() {
        collectionView.bindFrameToSuperviewBounds()
    }
}

//extension BrMCollectionView: BrMDynamicHeightContainable {
//    public var contentHeight: CGFloat {
//        let contentInset = collectionView.contentInset
//        let verticalInsets = contentInset.top + contentInset.bottom
//        return collectionView.contentSize.height + verticalInsets
//    }
//
//    public var associatedScrollView: UIScrollView? {
//        collectionView
//    }
//}

