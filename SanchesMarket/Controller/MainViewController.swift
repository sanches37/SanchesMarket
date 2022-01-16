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
        mainCollectionViewDataSource.decidedListLayout(collectionView)
        mainCollectionViewDataSource.requestProductList(collectionView)
        
    }
    
    private func registeredIdentifier() {
        collectionView.register(UINib(nibName: ProductCell.listNibName, bundle: nil), forCellWithReuseIdentifier: ProductCell.listIdentifier)
        collectionView.register(UINib(nibName: ProductCell.gridNibName, bundle: nil), forCellWithReuseIdentifier: ProductCell.listIdentifier)
    }
}
