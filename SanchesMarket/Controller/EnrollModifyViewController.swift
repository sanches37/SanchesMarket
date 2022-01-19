//
//  EnrollModifyViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import UIKit

class EnrollModifyViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var enrollModifyButton: UIBarButtonItem!
    
    private let enrollModifyCollectionViewDataSource =
    EnrollModifyViewCollectionViewDataSource()
    private let mainTitle = "상품"
    var topItemTitle: String = ""
    private let photoSelectButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTitle()
        setUpDataSourceContent()
    }
    
    private func setUpDataSourceContent() {
        enrollModifyCollectionViewDataSource.photoSelectButton.append(photoSelectButton)
    }
    
    private func setUpTitle() {
        self.title = mainTitle + topItemTitle
        enrollModifyButton.title = topItemTitle
    }
    
    private func setUpPhotoSelectButton() {
        photoSelectButton.addTarget(
            self, action: #selector(movePhotoAlbum(_:)), for: .touchUpInside)
    }
    
    @objc func movePhotoAlbum(_ sender: UIButton) {
        
    }
}
