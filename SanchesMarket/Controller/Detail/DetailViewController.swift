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
    private let detailCollectionViewDelegate = DetailCollectionViewDelegate()
    private var observe: NSKeyValueObservation?
    var landscape: [NSLayoutConstraint]?
    var portrait: [NSLayoutConstraint]?
    var isPortrait: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processCollectionView()
        registeredIdetifier()
        setUpContent()
        setUpDataSourceContent()
        setUpNavigationTitle()
        setUpKVO()
    }
    
    override func viewWillTransition(
        to size: CGSize,with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        view.subviews.forEach { $0.removeFromSuperview() }
        setUpContent()
    }
    
    private func setUpContent() {
        view.addSubview(content.scrollView)
        if  UIDevice.current.orientation.isLandscape {
            content.setUpLandscape(view: view)
        } else {
            content.setUpPortrait(view: view)
        }
    }
    
    private func processCollectionView() {
        content.photoCollectionView.dataSource = detailCollectionViewDataSource
        content.photoCollectionView.delegate = detailCollectionViewDelegate
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
    
    private func setUpKVO() {
        observe =
        detailCollectionViewDelegate.observe(\.currentPageNumber, options: [.new]) {  _, change in
            if let currentPageNumber = change.newValue {
                self.content.setUpCurrentPageNumber(number: currentPageNumber)
            }
        }
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
    
    func setUpDetail(product: Product) {
        self.title = product.title
        detailCollectionViewDataSource.setUpPhotos(thumbnails: product.thumbnails)
        requestDetail(id: product.id)
    }
}
