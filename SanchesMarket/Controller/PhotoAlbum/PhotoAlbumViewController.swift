//
//  PhotoAlbumViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/20.
//

import UIKit
import Photos.PHAsset

class PhotoAlbumViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    static let identifier = "PhotoAlbumVC"
    private let photoAlbumCollectionViewDataSource =
    PhotoAlbumCollectionViewDataSource()
    let photoAlbumCollectionViewDelegate =
    PhotoAlbumCollectionViewDelegate()
    
    private var selectedImage: (([UIImage]) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processCollectionView()
        registeredContent()
        setUpDataSourceContent()
    }
    
    private func processCollectionView() {
        collectionView.dataSource = photoAlbumCollectionViewDataSource
        collectionView.delegate = photoAlbumCollectionViewDelegate
    }
    
    private func registeredContent() {
        collectionView.register(PhotoAlbumCell.self, forCellWithReuseIdentifier: PhotoAlbumCell.identifier)
        PHPhotoLibrary.shared().register(self)
    }
    
    private func setUpDataSourceContent() {
        photoAlbumCollectionViewDataSource.photoAlbumManager.requestPhotosAuthorization {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        photoAlbumCollectionViewDataSource.decidedCollectionViewLayout(collectionView)
    }
    
    func getSelectedImage(completion: @escaping (([UIImage])) -> Void) {
        self.selectedImage = completion
    }
    
    @IBAction func resultPhotoButton(_ sender: UIBarButtonItem) {
        selectedImage?(photoAlbumCollectionViewDelegate.selectPhotoImage())
        navigationController?.popViewController(animated: true)
    }
}

extension PhotoAlbumViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        photoAlbumCollectionViewDataSource.photoAlbumManager.initializedPhotos()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
