//
//  DetailViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class DetailViewController: UIViewController {
    private let content = DetailContentView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpContent()
    }
    
    private func setUpContent() {
        content.setUpScrollView(view: view)
    }
}
