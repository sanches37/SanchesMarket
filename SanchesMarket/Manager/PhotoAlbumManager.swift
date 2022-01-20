//
//  PhotoAlbumManager.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/20.
//

import UIKit
import Photos.PHAsset

struct PhotoAlbumManager {
    private let allPhotos: PHFetchResult<PHAsset> =
    PHAsset.fetchAssets(with: PHFetchOptions())
    
    @discardableResult
    func getAllPhotos() -> PHFetchResult<PHAsset> {
        return allPhotos
    }
    
    func initializeAllPhotos(collectionView: UICollectionView) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                getAllPhotos()
                DispatchQueue.main.async {
                    collectionView.reloadData()
                }
            }
        }
    }
}
