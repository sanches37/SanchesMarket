//
//  EnrollModifyViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import UIKit

class EnrollModifyViewController: UIViewController {
    private let mainTitle = "상품"
    var topItemTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTitle()
    }
    
    private func setUpTitle() {
        self.title = mainTitle + topItemTitle
    }
}
