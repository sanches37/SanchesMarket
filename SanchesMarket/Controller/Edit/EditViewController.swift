//
//  EditViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import UIKit

class EditViewController: UIViewController {
    @IBOutlet weak var editButton: UIBarButtonItem!
    static let enrollTitle = "상품 등록"
    static let modifyTitle = "상품 수정"
    private let PhotoLimitCount = 5
    private let editCollectionViewDataSource =
    EditCollectionViewDataSource()
    private let content = EditContentView()
    private let networkManager = NetworkManager()
    private let parsingManager = ParsingManager()
    private lazy var keyboardManager =
    KeyboardManager(view: self.view, scrollView: content.scrollView)
    private var multipartFormData = MultipartFormData()
    private var editImpormation: Editable?
    private var medias: [Media] = []
    private var observe: NSKeyValueObservation?
    private var id: Int = 0
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeEditImpormation()
        processCollectionView()
        registeredIdetifier()
        setUpContent()
        setUpDataSourceContent()
        setUpButton()
        setUpKVO()
        setUpKeyboard()
    }
    
    override func viewWillTransition(to size: CGSize,
                                     with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        content.setUpPhotoCollectionViewConstraint()
    }
    
    private func processCollectionView() {
        content.photoCollectionView.dataSource = editCollectionViewDataSource
    }
    
    private func registeredIdetifier() {
        content.photoCollectionView.register(EditPhotoSelectCell.self,
                                             forCellWithReuseIdentifier: EditPhotoSelectCell.identifier)
        content.photoCollectionView.register(EditPhotoCell.self,
                                             forCellWithReuseIdentifier: EditPhotoCell.identifier)
    }
    
    private func initializeEditImpormation() {
        if self.title == Self.enrollTitle {
            editImpormation =
            PostImpormation(parameter: multipartFormData.parameter, image: medias)
        } else {
            editImpormation =
            PatchImpormation(id: self.id, parameter: multipartFormData.parameter, image: medias)
        }
    }
    
    func setUpNavigationTitle(title: String) {
        self.title = title
    }
    
    private func setUpContent() {
        content.setUpScrollView(view: view)
    }
    
    private func setUpDataSourceContent() {
        editCollectionViewDataSource.decidedCollectionViewLayout(content.photoCollectionView)
    }
    
    private func setUpButton() {
        editCollectionViewDataSource.getPhotoSelectButton { [weak self] selectButton in
            selectButton.addTarget(
                self, action: #selector(self?.movePhotoAlbum(_:)), for: .touchUpInside)
        }
        editCollectionViewDataSource.getPhotoDeleteButton { [weak self] deleteButton in
            deleteButton.addTarget(
                self, action: #selector(self?.removeSelectPhoto(_:)), for: .touchUpInside)
        }
    }
    
    private func setUpKVO() {
        observe =
        editCollectionViewDataSource.observe(\.photoAlbumImages, options: [.new]) { [weak self] _, change in
            if let images = change.newValue {
                self?.convertMedias(images: images)
            }
        }
    }
    
    private func convertMedias(images: [UIImage]) {
        var mediaArray: [Media] = []
        images.forEach { image in
            guard let media = Media(image: image, mimeType: .png) else {
                return
            }
            mediaArray.append(media)
        }
        medias = mediaArray
    }
    
    private func setUpKeyboard() {
        keyboardManager.setUpKeyboard()
    }
    
    private func checkEssentialImage() -> Bool {
        guard let essentialElement = editImpormation?.essentialElement else {
            return false
        }
        if essentialElement.minimumImage <= medias.count {
            return true
        } else {
            self.showAlert(message: "최소 \(essentialElement.minimumImage)개의 이미지를 등록해야합니다.")
            return false
        }
    }
    
    private func checkEssentialParameter() -> Bool {
        guard let essentialElement = editImpormation?.essentialElement else {
            return false
        }
        var missingText: [String] = []
        content.createEdit().forEach { (key, value) in
            if value.isEmpty {
                missingText.append(key)
            }
        }
        let necessaryText =
        essentialElement.text.filter { missingText.contains($0) }
        
        if necessaryText.isEmpty {
            return true
        } else {
            self.showAlert(message: "\(necessaryText) 필수입력사항입니다")
            return false
        }
    }
    
    func receiveModifyInformation(product: Product,
                                  password: String,
                                  images: [UIImage]) {
        self.id = product.id
        multipartFormData.password = password
        content.setUpModifyText(product: product)
        editCollectionViewDataSource.addPhotoAlbumImage(images: images)
    }
    
    private func setUpMultipartParameter() {
        content.createEdit().forEach { (key, value) in
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
    
    private func reqeustEdit(completion: @escaping (Product) -> Void) {
        guard let requestAPI = self.editImpormation?.requestAPI else { return }
        self.networkManager.commuteWithAPI(api: requestAPI) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: "시스템문제로 실패하였습니다. 관리자에게 연락해주세요")
                    debugPrint(error.errorDescription)
                }
            case .success(let data):
                guard let product = try? self.parsingManager.decodedJSONData(
                    type: Product.self, data: data) else {
                        return
                    }
                completion(product)
            }
        }
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        guard checkEssentialImage() else { return }
        guard checkEssentialParameter() else { return }
        setUpMultipartParameter()
        if editImpormation?.essentialElement == .post {
            self.setUpPasswordAlert { [weak self] password in
                guard let self = self else { return }
                self.multipartFormData.password = password
                self.initializeEditImpormation()
                self.reqeustEdit { product in
                    DispatchQueue.main.async {
                        self.showAlert(message: "\(product.id)번에 글이 등록되었습니다") {
                            NotificationCenter.default.post(
                                name: .enrollAfter,
                                object: nil,
                                userInfo: ["enrollId": product.id])
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            }
        } else {
            self.initializeEditImpormation()
            reqeustEdit { product in
                DispatchQueue.main.async {
                    self.showAlert(message: "\(product.id)번 글이 수정되었습니다") {
                        NotificationCenter.default.post(
                            name: .modifyAfter,
                            object: nil,
                            userInfo: ["photo": self.editCollectionViewDataSource.photoAlbumImages,
                                       "modifyId": product.id
                                      ])
                        self.navigationController?.popViewController(animated: true)
                    }
                }
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
