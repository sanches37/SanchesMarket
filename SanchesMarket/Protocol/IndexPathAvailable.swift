//
//  performsegueProtocol.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import Foundation

protocol IndexPathAvailable: NSObject {
    func getCollectionViewIndexPath(indexPath: IndexPath)
    func operatePerformSegue(indexPath: IndexPath)
    func updateDeleteIndexPath()
}
