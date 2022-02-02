//
//  CompositionalLayoutBuilder.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/16.
//

import UIKit

class CompositionalLayoutBuilder {
    private var portraitHorizontalSize: NSCollectionLayoutDimension = .fractionalWidth(1/1)
    private lazy var landscapeHorizontalSize: NSCollectionLayoutDimension = portraitHorizontalSize
    private var portraitVerticalSize: NSCollectionLayoutDimension = .absolute(100)
    private lazy var landscapeVerticalSize: NSCollectionLayoutDimension = portraitVerticalSize
    private var scrollDirection: ScrollDirection = .vertical
    private var cellMargin: NSDirectionalEdgeInsets =
    NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    private var viewMargin: NSDirectionalEdgeInsets =
    NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    private var scrollingBehavior: UICollectionLayoutSectionOrthogonalScrollingBehavior =
        .continuous
    
    func setPortraitHorizontalSize(
        _ size: NSCollectionLayoutDimension) -> CompositionalLayoutBuilder {
            self.portraitHorizontalSize = size
            return self
        }
    
    func setLandscapeHorizontalSize(
        _ size: NSCollectionLayoutDimension) -> CompositionalLayoutBuilder {
            self.landscapeHorizontalSize = size
            return self
        }
    
    func setPortraitVerticalSize(
        _ size: NSCollectionLayoutDimension) -> CompositionalLayoutBuilder {
            self.portraitVerticalSize = size
            return self
        }
    
    func setLandscapeVerticalSize(
        _ size: NSCollectionLayoutDimension) -> CompositionalLayoutBuilder {
            self.landscapeVerticalSize = size
            return self
        }
    
    func setScrollDirection(
        _ direction: ScrollDirection) -> CompositionalLayoutBuilder {
            self.scrollDirection = direction
            return self
        }
    
    func setCellMargin(
        _ margin: NSDirectionalEdgeInsets) -> CompositionalLayoutBuilder {
            self.cellMargin = margin
            return self
        }
    
    func setViewMargin(
        _ margin: NSDirectionalEdgeInsets) -> CompositionalLayoutBuilder {
            self.viewMargin = margin
            return self
        }
    
    func setScrollingBehavior(_ behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior) -> CompositionalLayoutBuilder {
        self.scrollingBehavior = behavior
        return self
    }
    
    func build() -> CompositionalLayoutProduct {
        return CompositionalLayoutProduct(
            portraitHorizontalSize: portraitHorizontalSize,
            landscapeHorizontalSize: landscapeHorizontalSize,
            portraitVerticalSize: portraitVerticalSize,
            landscapeVerticalSize: landscapeVerticalSize,
            scrollDirection: scrollDirection,
            cellMargin: cellMargin,
            viewMargin: viewMargin,
            scrollingBehavior: scrollingBehavior)
    }
}
