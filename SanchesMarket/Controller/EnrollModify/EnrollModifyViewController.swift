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
        collectionView.register(EnrollModifyPhotoCell.self, forCellWithReuseIdentifier: EnrollModifyPhotoCell.identifier)
    }
    
    private func setUpDataSourceContent() {
        enrollModifyCollectionViewDataSource.decidedCollectionViewLayout(collectionView)
    }
    
    private func setUpTitle() {
        self.title = mainTitle + topItemTitle
        enrollModifyButton.title = topItemTitle
    }
    
    private func setUpButton() {
        enrollModifyCollectionViewDataSource.getPhotoSelectButton { selectButton in
            selectButton.addTarget(
                self, action: #selector(self.movePhotoAlbum(_:)), for: .touchUpInside)
        }
        enrollModifyCollectionViewDataSource.getPhotoDeleteButton { deleteButton in
            deleteButton.addTarget(
                self, action: #selector(self.removeSelectPhoto(_:)), for: .touchUpInside)
        }
    }
    
    @objc func movePhotoAlbum(_ sender: UIButton) {
        guard let convertPhotoAlbumViewController =
                storyboard?.instantiateViewController(identifier: PhotoAlbumViewController.identifier) as? PhotoAlbumViewController else {
                    return
                }
        convertPhotoAlbumViewController.getSelectedImage { images in
            DispatchQueue.main.async {
                self.enrollModifyCollectionViewDataSource.addPhotoAlbumImage(images: images)
                self.collectionView.reloadData()
            }
        }
        navigationController?.pushViewController(
            convertPhotoAlbumViewController, animated: true)
    }
    
    @objc func removeSelectPhoto(_ sender: UIButton) {
        enrollModifyCollectionViewDataSource.removePhotoAlbumImage(
            index: sender.tag)
        collectionView.reloadData()
    }
}
