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
        
        processCollectionView()
        registeredIdetifier()
        setUpDataSourceContent()
        setUpButton()
        setUpTitle()
    }
    
    private func processCollectionView() {
        collectionView.dataSource = enrollModifyCollectionViewDataSource
    }
    
    private func registeredIdetifier() {
        collectionView.register(EnrollModifyPhotoSelectCell.self, forCellWithReuseIdentifier: EnrollModifyPhotoSelectCell.identifier)
    }
    
    private func setUpDataSourceContent() {
        enrollModifyCollectionViewDataSource.decidedListLayout(collectionView)
        enrollModifyCollectionViewDataSource.photoSelectButton.append(photoSelectButton)
    }
    
    private func setUpTitle() {
        self.title = mainTitle + topItemTitle
        enrollModifyButton.title = topItemTitle
    }
    
    private func setUpButton() {
        photoSelectButton.addTarget(
            self, action: #selector(movePhotoAlbum(_:)), for: .touchUpInside)
    }
    
    @objc func movePhotoAlbum(_ sender: UIButton) {
    }
    

}
