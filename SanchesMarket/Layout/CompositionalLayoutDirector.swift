//
//  CompositionalLayoutDirector.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/16.
//

import UIKit

struct CompositionalLayoutDirector {
    func createMainList() -> CompositionalLayoutProduct {
        let builder = CompositionalLayoutBuilder()
            .setViewMargin(NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
        return builder.build()
    }
    
    func createMainGrid() -> CompositionalLayoutProduct {
        let builder = CompositionalLayoutBuilder()
            .setPortraitHorizontalNumber(2)
            .setLandscapeHorizontalNumber(4)
            .setCellVerticalSize(.absolute(250))
            .setCellMargin(
                NSDirectionalEdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .setViewMargin(
                NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
        return builder.build()
    }
    
    func createEnrollModify() -> CompositionalLayoutProduct {
        let builder = CompositionalLayoutBuilder()
            .setPortraitHorizontalNumber(4)
            .setLandscapeHorizontalNumber(4)
            .setCellVerticalSize(.fractionalHeight(1/6))
            .setScrollDirection(.horizontal)
            .setCellMargin(
                NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
            .setViewMargin(
                NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
        return builder.build()
    }
}
