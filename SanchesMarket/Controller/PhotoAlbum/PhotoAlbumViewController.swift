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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processCollectionView()
        registeredIdentifier()
        setUpDataSourceContent()
    }
    
    private func processCollectionView() {
        collectionView.dataSource = photoAlbumCollectionViewDataSource
    }
    
    private func registeredIdentifier() {
        collectionView.register(PhotoAlbumCell.self, forCellWithReuseIdentifier: PhotoAlbumCell.identifier)
    }
    
    private func setUpDataSourceContent() {
        photoAlbumCollectionViewDataSource.photoAlbumManager.initializeAllPhotos(collectionView: collectionView)
        photoAlbumCollectionViewDataSource.decidedCollectionViewLayout(collectionView)
    }
}
