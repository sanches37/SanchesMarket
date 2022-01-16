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
    private let parsingManager = ParsingManager()
    private let layoutDirector = CompositionalLayoutDirector()
    private var changeIdentifier = ProductCell.listIdentifier
    private let page = 1
}

extension MainViewControllerDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: changeIdentifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        let productForItem = productList[indexPath.item]
        cell.productConfigure(product: productForItem,
                              identifier: changeIdentifier)
        
        return cell
    }
    
    func requestProductList(_ collectionView: UICollectionView) {
        self.networkManager.commuteWithAPI(api: GetItemsApi(page: page)) { result in
            if case .success(let data) = result {
                guard let product = try? self.parsingManager.decodedJSONData(type: ProductCollection.self, data: data) else {
                    return
                }
                self.productList.append(contentsOf: product.items)
                
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }
        }
    }
    
    func decidedListLayout(_ collectionView: UICollectionView) {
        collectionView.collectionViewLayout = layoutDirector.createMainList().create()
    }
    
    func selectedView(_ sender: UISegmentedControl,
                      _ collectionView: UICollectionView) {
        switch sender.selectedSegmentIndex {
        case 0:
            changeIdentifier = ProductCell.listIdentifier
            decidedListLayout(collectionView)
            collectionView.reloadData()
        default:
            changeIdentifier = ProductCell.gridIdentifier
            collectionView.collectionViewLayout =
            layoutDirector.createMainGrid().create()
            collectionView.reloadData()
            
        }
    }
}

    
    
