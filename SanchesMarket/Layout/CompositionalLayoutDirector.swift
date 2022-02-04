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
            .setPortraitHorizontalSize(.fractionalWidth(1/2))
            .setLandscapeHorizontalSize(.fractionalWidth(1/4))
            .setPortraitVerticalSize(.absolute(250))
            .setCellMargin(
                NSDirectionalEdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
            .setViewMargin(
                NSDirectionalEdgeInsets(top: 4, leading: 0, bottom: 0, trailing: 0))
        return builder.build()
    }
    
    func createEdit() -> CompositionalLayoutProduct {
        let builder = CompositionalLayoutBuilder()
            .setPortraitHorizontalSize(.fractionalWidth(1/3))
            .setLandscapeHorizontalSize(.fractionalWidth(1/8))
            .setPortraitVerticalSize(.fractionalWidth(1/3))
            .setLandscapeVerticalSize(.fractionalWidth(1/8))
            .setScrollDirection(.horizontal)
            .setCellMargin(
                NSDirectionalEdgeInsets(top: 5, leading: 0, bottom: 5, trailing: 5))
            .setViewMargin(
                NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 0))
        return builder.build()
    }
    
    func createPhotoAlbum() -> CompositionalLayoutProduct {
        let builder = CompositionalLayoutBuilder()
            .setPortraitHorizontalSize(.fractionalWidth(1/3))
            .setLandscapeHorizontalSize(.fractionalWidth(1/5))
            .setPortraitVerticalSize(.fractionalWidth(1/3))
            .setLandscapeVerticalSize(.fractionalWidth(1/5))
            .setCellMargin(
                NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
            .setViewMargin(
                NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1))
        return builder.build()
    }
    
    func createDetail() -> CompositionalLayoutProduct {
        let builder = CompositionalLayoutBuilder()
            .setPortraitHorizontalSize(.fractionalWidth(1))
            .setPortraitVerticalSize(.fractionalWidth(1))
            .setScrollDirection(.horizontal)
            .setScrollingBehavior(.paging)
        return builder.build()
    }
}
