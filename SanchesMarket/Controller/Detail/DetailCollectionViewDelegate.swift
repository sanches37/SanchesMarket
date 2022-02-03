//
//  DetailCollectionViewDelegate.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/03.
//

import UIKit

class DetailCollectionViewDelegate: NSObject {
    @objc dynamic private(set) var currentPageNumber = 0
}

extension DetailCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
          let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint) else {
            return
        }
        currentPageNumber = visibleIndexPath.item
    }
}
