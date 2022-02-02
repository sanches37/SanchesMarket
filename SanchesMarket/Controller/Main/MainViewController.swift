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
    static let segueEditIdentifier = "presentToEdit"
    static let segueDetailIdentifier = "presentToDetail"
    private let mainCollectionViewDataSource = MainCollectionViewDataSource()
    private let mainCollectionViewDelegate = MainCollectionViewDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processCollectionView()
        registeredIdentifier()
        setUpDataSourceContent()
    }
    
    private func processCollectionView() {
        collectionView.dataSource = mainCollectionViewDataSource
        collectionView.delegate = mainCollectionViewDelegate
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
        mainCollectionViewDelegate.delegate = self
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

extension MainViewController: performSegueDelegate {
    func operatePerformSegue(indexPath: IndexPath) {
        performSegue(withIdentifier: MainViewController.segueDetailIdentifier, sender: mainCollectionViewDataSource.productList[indexPath.item])
    }
    
    @IBAction func editButton(_ sender: Any) {
        self.showEditAction()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editViewController = segue.destination as? EditViewController,
           let labelString = sender as? String {
            editViewController.topItemTitle = labelString
        } else if let detailViewController = segue.destination as? DetailViewController,
                  let product = sender as? Product {
            detailViewController.setUpDetail(product: product)
        }
    }
}
