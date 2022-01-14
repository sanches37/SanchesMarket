//
//  MainViewControllerDataSource.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/14.
//

import Foundation
import UIKit

class MainViewControllerDataSource: NSObject {
    private var productList: [Product] = []
    private let networkManager = NetworkManager()
    
}

extension MainViewControllerDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.listIdentifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        let productForItem = productList[indexPath.item]
        
        return cell
    }
}

    
    
