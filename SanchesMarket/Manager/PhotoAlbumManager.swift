//
//  PhotoAlbumManager.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/20.
//

import UIKit
import Photos.PHAsset

class PhotoAlbumManager {
    private var photos: PHFetchResult<PHAsset>?
    
    func getPhotos() -> PHFetchResult<PHAsset>? {
        return photos
    }
    
    func initializedPhotos() {
        self.photos =
        PHAsset.fetchAssets(with: PHFetchOptions())
    }
    
    func requestPhotosAuthorization(completion: @escaping (() -> Void)) {
        if #available(iOS 14.0, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .limited {
                    self.initializedPhotos()
                    completion()
                } else if status == .authorized {
                    self.initializedPhotos()
                    completion()
                }
            }
        } else {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    self.initializedPhotos()
                    completion()
                }
            }
        }
    }
    
    func requestImage(asset: PHAsset, completion: @escaping ((UIImage) -> Void)) {
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        PHImageManager().requestImage(for: asset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFill, options: options) { (image, _) in
            if let image = image {
                completion(image)
            }
        }
    }
}
