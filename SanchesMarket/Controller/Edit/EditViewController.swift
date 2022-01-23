//
//  EnrollModifyViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var editButton: UIBarButtonItem!
    private let PhotoLimitCount = 5
    private let editCollectionViewDataSource =
    EditCollectionViewDataSource()
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
        collectionView.dataSource = editCollectionViewDataSource
    }
    
    private func registeredIdetifier() {
        collectionView.register(EditPhotoSelectCell.self, forCellWithReuseIdentifier: EditPhotoSelectCell.identifier)
        collectionView.register(EditPhotoCell.self, forCellWithReuseIdentifier: EditPhotoCell.identifier)
    }
    
    private func setUpDataSourceContent() {
        editCollectionViewDataSource.decidedCollectionViewLayout(collectionView)
    }
    
    private func setUpTitle() {
        self.title = mainTitle + topItemTitle
        editButton.title = topItemTitle
    }
    
    private func setUpButton() {
        editCollectionViewDataSource.getPhotoSelectButton { selectButton in
            selectButton.addTarget(
                self, action: #selector(self.movePhotoAlbum(_:)), for: .touchUpInside)
        }
        editCollectionViewDataSource.getPhotoDeleteButton { deleteButton in
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
                self.editCollectionViewDataSource.addPhotoAlbumImage(images: images)
                self.collectionView.reloadData()
            }
        }
        
        convertPhotoAlbumViewController.getSelectableImageCount(
            to: PhotoLimitCount - editCollectionViewDataSource.photoAlbumImages.count)
        
        if editCollectionViewDataSource.photoAlbumImages.count < PhotoLimitCount {
            navigationController?.pushViewController(
                convertPhotoAlbumViewController, animated: true)
        } else {
            let photoLimitAlert = UIAlertController(title: "이미지는 5장까지 등록할 수 있습니다", message: nil, preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            photoLimitAlert.addAction(ok)
            present(photoLimitAlert, animated: true)
        }
    }
    
    @objc func removeSelectPhoto(_ sender: UIButton) {
        editCollectionViewDataSource.removePhotoAlbumImage(
            index: sender.tag)
        collectionView.reloadData()
    }
}
