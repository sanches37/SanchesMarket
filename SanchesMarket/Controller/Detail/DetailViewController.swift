//
//  DetailViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class DetailViewController: UIViewController {
    private let content = DetailContentView()
    private let networkManager = NetworkManager()
    private let parsingManager = ParsingManager()
    
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
        label.font = .preferredFont(forTextStyle: .title2, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        self.navigationItem.titleView = label
    }
    
    func requestDetail(id: Int) {
        networkManager.commuteWithAPI(api: GetItemAPI(id: id)) { result in
            if case .success(let data) = result {
                guard let product = try? self.parsingManager.decodedJSONData(type: Product.self, data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.content.setUpLabel(product: product)
                }
            }
        }
    }
}
