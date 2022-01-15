//
//  CompositionalLayoutBuilder.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/16.
//

import UIKit

class CompositionalLayoutBuilder {
    private var portraitHorizontalNumber: Int = 1
    private var landscapeHorizontalNumber: Int = 1
    private var cellVerticalSize: NSCollectionLayoutDimension = .absolute(100)
    private var scrollDirection: ScrollDirection = .vertical
    private var cellMargin: NSDirectionalEdgeInsets =
    NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    private var viewMargin: NSDirectionalEdgeInsets =
    NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
    
    func setPortraitHorizontalNumber(_ number: Int) -> CompositionalLayoutBuilder {
        self.portraitHorizontalNumber = number
        return self
    }
    func setLandscapeHorizontalNumber(_ number: Int) -> CompositionalLayoutBuilder {
        self.landscapeHorizontalNumber = number
        return self
    }
    func setCellVerticalSize(
        _ size: NSCollectionLayoutDimension) -> CompositionalLayoutBuilder {
        self.cellVerticalSize = size
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
    func build() -> CompositionalLayoutProduct {
        return CompositionalLayoutProduct(
            portraitHorizontalNumber: portraitHorizontalNumber,
            landscapeHorizontalNumber: landscapeHorizontalNumber,
            cellVerticalSize: cellVerticalSize,
            scrollDirection: scrollDirection,
            cellMargin: cellMargin,
            viewMargin: viewMargin)
    }
}
