//
//  MainViewControllerDataSource.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/14.
//

import UIKit

class MainCollectionViewDataSource: NSObject {
    private(set) var productList: [Product] = []
    private let networkManager = NetworkManager()
    private let parsingManager = ParsingManager()
    private let imageManager = ImageManager()
    private let layoutDirector = CompositionalLayoutDirector()
    private var changeIdentifier = ProductCell.listIdentifier
    private var netxPage = 1
    weak var loadingIndicator: LodingIndicatable?
    
    func addProduct(product: Product) {
        productList.append(product)
    }
    
    func updateProductList(product: Product, index: Int) {
        productList[index] = product
    }
    
    func removeProductListIndex(index: Int) {
        productList.remove(at: index)
    }
}

extension MainCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: changeIdentifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        let productForItem = productList[indexPath.item]
        cell.productConfigure(product: productForItem,
                              identifier: changeIdentifier,
                              imageManager: imageManager)
        return cell
    }
    
    func requestProductList(_ collectionView: UICollectionView) {
        loadingIndicator?.startAnimating()
        loadingIndicator?.isHidden(false)
        self.networkManager.commuteWithAPI(
            api: GetItemsAPI(page: netxPage)) { result in
                if case .success(let data) = result {
                    guard let product = try? self.parsingManager.decodedJSONData(type: ProductCollection.self, data: data) else {
                        return
                    }
                    self.productList.append(contentsOf: product.items)
                    self.netxPage += 1
                    DispatchQueue.main.async {
                        collectionView.reloadData()
                        self.loadingIndicator?.stopAnimating()
                        self.loadingIndicator?.isHidden(true)
                    }
                }
            }
    }
    
    func requestEditAfter(id: Int, completion: @escaping (Product) -> Void) {
        self.networkManager.commuteWithAPI(
            api: GetItemAPI(id: id)) { result in
                if case .success(let data) = result {
                    guard let product =
                            try? self.parsingManager.decodedJSONData(type: Product.self, data: data) else {
                                return
                            }
                    completion(product)
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

extension MainCollectionViewDataSource: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if indexPath.item == productList.count - 1 {
                requestProductList(collectionView)
            }
        }
    }
}


