//
//  DetailCollectionViewDelegate.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class MainCollectionViewDelegate: NSObject {
    weak var delegate: performSegueDelegate?
}

extension MainCollectionViewDelegate: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        delegate?.operatePerformSegue(indexPath: indexPath)
    }
}
