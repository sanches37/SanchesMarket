//
//  EnrollModifyCollectionViewDataSource.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import UIKit

class EnrollModifyViewCollectionViewDataSource: NSObject {
    private let layoutDirector = CompositionalLayoutDirector()
    var photoSelectButton: [UIButton] = []
}

extension EnrollModifyViewCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoSelectButton.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let photoSelectCell = collectionView.dequeueReusableCell(withReuseIdentifier: EnrollModifyPhotoSelectCell.identifier, for: indexPath) as? EnrollModifyPhotoSelectCell else {
            return UICollectionViewCell()
        }
        let selectButton = photoSelectButton[indexPath.item]
        photoSelectCell.configure(photoSelectButton: selectButton)
        
        return photoSelectCell
    }
    
    func decidedListLayout(_ collectionView: UICollectionView) {
        collectionView.collectionViewLayout = layoutDirector.createEnrollModify().create()
    }
}
