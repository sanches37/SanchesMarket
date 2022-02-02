//
//  DetailCollectionViewDataSource.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class DetailCollectionViewDataSource: NSObject {
    private let layoutDirector = CompositionalLayoutDirector()
    private let imageManager = ImageManager()
    private var photos: [String] = []
    
    func setUpPhotos(thumbnails: [String]) {
        self.photos = thumbnails
    }
}

extension DetailCollectionViewDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailPhotoCell.identifier, for: indexPath) as? DetailPhotoCell else {
            return UICollectionViewCell()
        }
        let photoForItem = photos[indexPath.item]
        cell.photoConfigure(thumnail: photoForItem, imageManager: imageManager)
        
        return cell
    }
    
    func decidedCollectionViewLayout(_ collectionView: UICollectionView) {
        collectionView.collectionViewLayout = layoutDirector.createDetail().create()
    }
}
