//
//  CompositionalLayout.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/15.
//

import UIKit

struct CompositionalLayoutProduct {
    let portraitHorizontalSize: NSCollectionLayoutDimension
    let landscapeHorizontalSize: NSCollectionLayoutDimension
    let portraitVerticalSize: NSCollectionLayoutDimension
    let landscapeVerticalSize: NSCollectionLayoutDimension
    let scrollDirection: ScrollDirection
    let cellMargin: NSDirectionalEdgeInsets
    let viewMargin: NSDirectionalEdgeInsets
    let scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior
    
    func create() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (_, _) -> NSCollectionLayoutSection in
            return decidedSection()
        }
        return layout
    }
    
    private func decidedItem() -> NSCollectionLayoutItem {
        var horizontalSize: NSCollectionLayoutDimension {
            UIDevice.current.orientation.isLandscape ?
        landscapeHorizontalSize: portraitHorizontalSize
        }
        let itemSize = NSCollectionLayoutSize(widthDimension: horizontalSize, heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = cellMargin
        return item
    }
    
    private func decidedGroup() -> NSCollectionLayoutGroup {
        var verticalSize: NSCollectionLayoutDimension {
            UIDevice.current.orientation.isLandscape ?
        landscapeVerticalSize: portraitVerticalSize
        }
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: verticalSize)
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [decidedItem()])
        return group
    }
    
    private func decidedSection() -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: decidedGroup())
        if scrollDirection == .horizontal {
            section.orthogonalScrollingBehavior = scrollingBehavior
        }
        section.contentInsets = viewMargin
        return section
    }
}
