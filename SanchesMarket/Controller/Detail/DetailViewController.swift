//
//  DetailViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class DetailViewController: UIViewController {
    private let content = DetailContentView()
    private let networkManager = NetworkManager()
    private let parsingManager = ParsingManager()
    private let detailCollectionViewDataSource = DetailCollectionViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processCollectionView()
        registeredIdetifier()
        setUpContent()
        setUpDataSourceContent()
        setUpNavigationTitle()
    }
    
    private func setUpContent() {
        content.setUpScrollView(view: view)
    }
    
    private func processCollectionView() {
        content.photoCollectionView.dataSource = detailCollectionViewDataSource
    }
    
    private func registeredIdetifier() {
        content.photoCollectionView.register(DetailPhotoCell.self,
                                             forCellWithReuseIdentifier: DetailPhotoCell.identifier)
    }
    
    private func setUpDataSourceContent() {
        detailCollectionViewDataSource.decidedCollectionViewLayout(content.photoCollectionView)
    }
    
    private func setUpNavigationTitle() {
        content.navigationItemTitle.text = self.title
        self.navigationItem.titleView = content.navigationItemTitle
    }
    
    func setUpDetail(product: Product) {
        self.title = product.title
        detailCollectionViewDataSource.setUpPhotos(thumbnails: product.thumbnails)
        requestDetail(id: product.id)
    }
    
    private func requestDetail(id: Int) {
        networkManager.commuteWithAPI(api: GetItemAPI(id: id)) { result in
            if case .success(let data) = result {
                guard let product = try? self.parsingManager.decodedJSONData(type: Product.self, data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.content.setUpLabel(product: product)
                }
            }
        }
    }
}