//
//  EnrollModifyCollectionViewDataSource.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import UIKit

class EnrollModifyViewCollectionViewDataSource: NSObject {
    private let layoutDirector = CompositionalLayoutDirector()
    var photoSelectButton: ((UIButton) -> Void)?
    private var photoDeleteButton: ((UIButton) -> Void)?
    var photoAlbumImages: [UIImage] = []
}

extension EnrollModifyViewCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoAlbumImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == .zero {
            guard let photoSelectCell = collectionView.dequeueReusableCell(withReuseIdentifier: EnrollModifyPhotoSelectCell.identifier, for: indexPath) as? EnrollModifyPhotoSelectCell else {
                return UICollectionViewCell()
            }
            photoSelectButton?(photoSelectCell.photoSelectButton)
            return photoSelectCell
    
        } else {
            guard let photoCell = collectionView.dequeueReusableCell(withReuseIdentifier: EnrollModifyPhotoCell.identifier, for: indexPath) as? EnrollModifyPhotoCell else {
                return UICollectionViewCell()
            }
            let photoAlbumImageForItem = photoAlbumImages[indexPath.item - 1]
            photoDeleteButton?(photoCell.deleteButton)
            return photoCell
        }
    }
    
    func decidedListLayout(_ collectionView: UICollectionView) {
        collectionView.collectionViewLayout = layoutDirector.createEnrollModify().create()
    }
    
    func getPhotoSelectButton(completion: @escaping ((UIButton) -> Void)) {
        self.photoSelectButton = completion
    }
    
    func getPhotoDeleteButton(completion: @escaping ((UIButton) -> Void)) {
        self.photoDeleteButton = completion
    }
}
