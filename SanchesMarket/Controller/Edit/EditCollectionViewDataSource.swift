//
//  EnrollModifyCollectionViewDataSource.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import UIKit

class EditCollectionViewDataSource: NSObject {
    private let layoutDirector = CompositionalLayoutDirector()
    private var photoSelectButton: ((UIButton) -> Void)?
    private var photoDeleteButton: ((UIButton) -> Void)?
    private(set) var photoAlbumImages: [UIImage] = []
}

extension EditCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAlbumImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == .zero {
            guard let photoSelectCell = collectionView.dequeueReusableCell(withReuseIdentifier: EditPhotoSelectCell.identifier, for: indexPath) as? EditPhotoSelectCell else {
                return UICollectionViewCell()
            }
            photoSelectCell.setPhotoSelectCount(count: photoAlbumImages.count)
            photoSelectButton?(photoSelectCell.photoSelectButton)
            
            return photoSelectCell
    
        } else {
            guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: EditPhotoCell.identifier, for: indexPath) as? EditPhotoCell else {
                return UICollectionViewCell()
            }
            let photoAlbumImageForItem = photoAlbumImages[indexPath.item - 1]
            photoCell.deleteButton.tag = indexPath.item - 1
            photoCell.configure(image: photoAlbumImageForItem)
            photoDeleteButton?(photoCell.deleteButton)
            
            return photoCell
        }
    }
    
    func decidedCollectionViewLayout(_ collectionView: UICollectionView) {
        collectionView.collectionViewLayout = layoutDirector.createEnrollModify().create()
    }
    
    func getPhotoSelectButton(completion: @escaping ((UIButton) -> Void)) {
        self.photoSelectButton = completion
    }
    
    func getPhotoDeleteButton(completion: @escaping ((UIButton) -> Void)) {
        self.photoDeleteButton = completion
    }
    
    func addPhotoAlbumImage(images: [UIImage]) {
        photoAlbumImages += images
    }
    
    func removePhotoAlbumImage(index: Int) {
        photoAlbumImages.remove(at: index)
    }
}
