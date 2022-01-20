//
//  PhotoAlbumViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/20.
//

import UIKit

class PhotoAlbumViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    private let photoAlbumCollectionViewDataSource =
    PhotoAlbumCollectionViewDataSource()
    private let photoAlbumCollectionViewDelegate =
    PhotoAlbumCollectionViewDelegate()
    static let identifier = "PhotoAlbumVC"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processCollectionView()
        registeredIdentifier()
        setUpDataSourceContent()
    }
    
    private func processCollectionView() {
        collectionView.dataSource = photoAlbumCollectionViewDataSource
        collectionView.delegate = photoAlbumCollectionViewDelegate
    }
    
    private func registeredIdentifier() {
        collectionView.register(PhotoAlbumCell.self, forCellWithReuseIdentifier: PhotoAlbumCell.identifier)
    }
    
    private func setUpDataSourceContent() {
        photoAlbumCollectionViewDataSource.photoAlbumManager.initializeAllPhotos(collectionView: collectionView)
        photoAlbumCollectionViewDataSource.decidedCollectionViewLayout(collectionView)
    }
}
