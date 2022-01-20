//
//  PhotoAlbumCollectionViewDataSource.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/21.
//

import UIKit

class PhotoAlbumCollectionViewDataSource: NSObject {
    private let layoutDirector = CompositionalLayoutDirector()
    let photoAlbumManager = PhotoAlbumManager()
}

extension PhotoAlbumCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoAlbumManager.getAllPhotos().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoAlbumCell.identifier, for: indexPath) as? PhotoAlbumCell else {
            return UICollectionViewCell()
        }
        let asset = photoAlbumManager.getAllPhotos()[indexPath.item]
        photoAlbumManager.requestImage(asset: asset) { image in
            cell.configure(image: image)
        }
        
        return cell
    }
    
    func decidedCollectionViewLayout(_ collecionView: UICollectionView) {
        collecionView.collectionViewLayout = layoutDirector.createPhotoAlbum().create()
    }
}
