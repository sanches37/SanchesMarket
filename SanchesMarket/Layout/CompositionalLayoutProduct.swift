//
//  CompositionalLayout.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/15.
//

import UIKit

struct CompositionalLayoutProduct {
    let portraitHorizontalNumber: Int
    let landscapeHorizontalNumber: Int
    let cellVerticalSize: NSCollectionLayoutDimension
    let scrollDirection: ScrollDirection
    let cellMargin: NSDirectionalEdgeInsets
    let viewMargin: NSDirectionalEdgeInsets
    
    func create() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection in
            return decidedSection()
        }
        return layout
    }

    private func decidedItem() -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = cellMargin
        return item
    }
    
    private func decidedGroup() -> NSCollectionLayoutGroup {
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: cellVerticalSize)
        var horizontalNumber: Int {
            UIDevice.current.orientation.isLandscape ?
        landscapeHorizontalNumber: portraitHorizontalNumber
        }
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: decidedItem(),
                                                       count: horizontalNumber)
        return group
    }
    
    private func decidedSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: decidedGroup())
        if scrollDirection == .horizontal {
            section.orthogonalScrollingBehavior = .continuous
        }
        section.contentInsets = viewMargin
        return section
    }
}
