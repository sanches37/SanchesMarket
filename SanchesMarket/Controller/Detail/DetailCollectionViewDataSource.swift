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
    private(set) var photos: [UIImage] = []
    
    func updatePhotos(photos: [UIImage]) {
        self.photos = photos
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
        cell.configure(photo: photoForItem)
        
        return cell
    }
    
    func requestImage(thumnails: [String]) {
        thumnails.forEach { thumnail in
            imageManager.fetchImage(url: thumnail) { image in
                DispatchQueue.main.async {
                    switch image {
                    case .success(let image):
                        self.photos.append(image)
                    case .failure(let error):
                        print(error.errorDescription)
                    }
                }
            }
        }
    }
    
    func decidedCollectionViewLayout(_ collectionView: UICollectionView) {
        collectionView.collectionViewLayout = layoutDirector.createDetail().create()
    }
}
