//
//  performsegueProtocol.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import Foundation

protocol performSegueDelegate: NSObject {
    func operatePerformSegue(indexPath: IndexPath)
}
