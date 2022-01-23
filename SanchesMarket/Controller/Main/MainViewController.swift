//
//  ViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/04.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lodingIndicator: UIActivityIndicatorView!
    
    private let mainCollectionViewDataSource = MainCollectionViewDataSource()
    static let segueIdentifier = "presentToEnrollModify"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processCollectionView()
        registeredIdentifier()
        setUpDataSourceContent()
    }
    
    private func processCollectionView() {
        collectionView.dataSource = mainCollectionViewDataSource
        collectionView.prefetchDataSource = mainCollectionViewDataSource
    }
    
    private func registeredIdentifier() {
        collectionView.register(UINib(nibName: ProductCell.listIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.listIdentifier)
        collectionView.register(UINib(nibName: ProductCell.gridIdentifier, bundle: nil), forCellWithReuseIdentifier: ProductCell.gridIdentifier)
    }
    
    private func setUpDataSourceContent() {
        mainCollectionViewDataSource.decidedListLayout(collectionView)
        mainCollectionViewDataSource.requestProductList(collectionView)
        mainCollectionViewDataSource.loadingIndicator = self
    }
    
    @IBAction func onCollectionViewTypeChanged(_ sender: UISegmentedControl) {
        mainCollectionViewDataSource.selectedView(sender, collectionView)
    }
}

extension MainViewController: LodingIndicatable {
    func startAnimating() {
        lodingIndicator.startAnimating()
    }
    
    func stopAnimating() {
        lodingIndicator.stopAnimating()
    }
    
    func isHidden(_ isHidden: Bool) {
        lodingIndicator.isHidden = isHidden
    }
}

extension MainViewController {
    @IBAction func enrollModifyButton(_ sender: Any) {
        self.showEditAction()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let enrollModifyViewController = segue.destination as? EditViewController else {
            return
        }
        guard let labelString = sender as? String else { return }
        enrollModifyViewController.topItemTitle = labelString
    }
}
