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
    
    func requestImage(thumnails: [String], completion: @escaping (Int) -> Void) {
        for (index, url) in thumnails.enumerated() {
            self.imageManager.fetchImage(url: url) { image in
                switch image {
                case .success(let image):
                    self.photos.append(image)
                    completion(index)
                case .failure(let error):
                    debugPrint(error.errorDescription)
                }
            }
        }
    }
    
    func decidedCollectionViewLayout(_ collectionView: UICollectionView) {
        collectionView.collectionViewLayout = layoutDirector.createDetail().create()
    }
}
