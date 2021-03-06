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
    private var selectIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processCollectionView()
        registeredIdentifier()
        setUpDataSourceContent()
        setUpNotification()
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
    
    private func setUpNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(operateEnrollAfter(_:)),
            name: .enrollAfter, object: nil)
        NotificationCenter.default.addObserver(
            self, selector: #selector(operateModifyAfter(_:)),
            name: .modifyAfter, object: nil)
    }
    
    @objc func operateEnrollAfter(_ notification: Notification) {
        guard let id = notification.userInfo?["enrollId"] as? Int else {
            return
        }
        mainCollectionViewDataSource.requestEditAfter(id: id) { result in
            self.mainCollectionViewDataSource.addProduct(product: result)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @objc func operateModifyAfter(_ notification: Notification) {
        guard let id = notification.userInfo?["modifyId"] as? Int,
        let selectIndex = selectIndex else {
            return
        }
        mainCollectionViewDataSource.requestEditAfter(id: id) { result in
            self.mainCollectionViewDataSource.updateProductList(product: result, index: selectIndex)
            DispatchQueue.main.async {
                self.collectionView.reloadItems(at: [IndexPath(item: selectIndex, section: .zero)])
            }
        }
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

extension MainViewController: IndexPathAvailable {
    func getCollectionViewIndexPath(indexPath: IndexPath) {
        self.selectIndex = indexPath.item
    }
    
    func operatePerformSegue(indexPath: IndexPath) {
        performSegue(withIdentifier: MainViewController.segueDetailIdentifier, sender: mainCollectionViewDataSource.productList[indexPath.item])
    }
    
    func updateDeleteIndexPath() {
        guard let index = selectIndex else { return }
        mainCollectionViewDataSource.removeProductListIndex(index: index)
        collectionView.deleteItems(at: [IndexPath(item: index, section: .zero)])
    }
}

extension MainViewController {
    @IBAction func editButton(_ sender: Any) {
        performSegue(withIdentifier: MainViewController.segueEditIdentifier, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let editViewController = segue.destination as? EditViewController {
            editViewController.setUpNavigationTitle(title: EditViewController.enrollTitle)
        } else if let detailViewController = segue.destination as? DetailViewController,
                  let product = sender as? Product {
            detailViewController.setUpDetail(product: product)
            detailViewController.delegate = self
        }
    }
}
