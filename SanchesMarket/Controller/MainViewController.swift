//
//  ViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/04.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let mainCollectionViewDataSource = MainViewControllerDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = mainCollectionViewDataSource
        collectionView.prefetchDataSource = mainCollectionViewDataSource
        registeredIdentifier()
        setUpDataSourceContent()
    }
    
    private func registeredIdentifier() {
        collectionView.register(UINib(nibName: ProductCell.listIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.listIdentifier)
        collectionView.register(UINib(nibName: ProductCell.gridIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.gridIdentifier)
    }
    
    private func setUpDataSourceContent() {
        mainCollectionViewDataSource.decidedListLayout(collectionView)
        mainCollectionViewDataSource.requestProductList(collectionView)
    }
    
    @IBAction func onCollectionViewTypeChanged(_ sender: UISegmentedControl) {
        mainCollectionViewDataSource.selectedView(sender, collectionView)
    }
}
