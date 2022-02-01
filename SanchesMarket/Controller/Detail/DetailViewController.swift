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
        setUpNavigationTitle()
    }
    
    private func setUpContent() {
        content.setUpScrollView(view: view)
    }
    
    func setUpTitle(title: String) {
        self.title = title
    }
    
    private func setUpNavigationTitle() {
        let label = UILabel(
            frame: CGRect(x: .zero, y: .zero, width: 100, height: 100))
        label.text = self.title
        label.textColor = UIColor.black
        label.font = UIFont.preferredFont(forTextStyle: .title2, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        self.navigationItem.titleView = label
    }
}
