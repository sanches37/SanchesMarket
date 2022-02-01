//
//  DetailCollectionViewDataSource.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class DetailCollectionViewDataSource: NSObject {
    private var photos: [UIImage] = []
}

extension DetailCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPhotoCell.identifier, for: indexPath) as? DetailPhotoCell else {
            return UICollectionViewCell()
        }
        return cell
    }
}
