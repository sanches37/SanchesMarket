//
//  EditViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var editButton: UIBarButtonItem!
    private let PhotoLimitCount = 5
    private let editCollectionViewDataSource =
    EditCollectionViewDataSource()
    private var multipartFormData = MultipartFormData()
    private let content = EditContentView()
    private lazy var keyboardManager =
    KeyboardManager(view: self.view, scrollView: content.scrollView)
    private let mainTitle = "상품"
    var topItemTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        processCollectionView()
        registeredIdetifier()
        setUpContent()
        setUpDataSourceContent()
        setUpTitle()
        setUpButton()
        setUpKeyboard()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        content.setUpPhotoCollectionViewConstraint()
    }
    
    private func processCollectionView() {
        content.photoCollectionView.dataSource = editCollectionViewDataSource
    }
    
    private func registeredIdetifier() {
        content.photoCollectionView.register(EditPhotoSelectCell.self, forCellWithReuseIdentifier: EditPhotoSelectCell.identifier)
        content.photoCollectionView.register(EditPhotoCell.self, forCellWithReuseIdentifier: EditPhotoCell.identifier)
    }
    
    private func setUpContent() {
        content.setUpScrollView(view: view)
    }
    
    private func setUpDataSourceContent() {
        editCollectionViewDataSource.decidedCollectionViewLayout(content.photoCollectionView)
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
    
    private func setUpKeyboard() {
        keyboardManager.setUpKeyboard()
    }
    
    private func setUpMultipartParameter() {
        content.createPostAndPatch().forEach { (key, value) in
            guard let item = EditParameter(rawValue: key) else { return }
            switch item {
            case .title:
                multipartFormData.title = value
            case .currency:
                multipartFormData.currency = value
            case .price:
                multipartFormData.price = Int(value)
            case .discountedPrice:
                multipartFormData.discountedPrice = Int(value)
            case .stock:
                multipartFormData.stock = Int(value)
            case .description:
                multipartFormData.descriptions = value
            }
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
                self.content.photoCollectionView.reloadData()
            }
        }
        convertPhotoAlbumViewController.photoAlbumCollectionViewDelegate.getSelectImageCount(
            to: PhotoLimitCount - editCollectionViewDataSource.photoAlbumImages.count)
        
        if editCollectionViewDataSource.photoAlbumImages.count < PhotoLimitCount {
            navigationController?.pushViewController(
                convertPhotoAlbumViewController, animated: true)
        } else {
            self.showAlert(message: "사진은 5장까지만 등록할 수 있습니다")
        }
    }
    
    @objc func removeSelectPhoto(_ sender: UIButton) {
        editCollectionViewDataSource.removePhotoAlbumImage(
            index: sender.tag)
        content.photoCollectionView.reloadData()
    }
}
