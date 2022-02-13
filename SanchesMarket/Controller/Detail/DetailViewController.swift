//
//  DetailViewController.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class DetailViewController: UIViewController {
    static let segueModifyIdentifier = "presentToModify"
    private let content = DetailContentView()
    private let networkManager = NetworkManager()
    private let parsingManager = ParsingManager()
    private let detailCollectionViewDataSource = DetailCollectionViewDataSource()
    private let detailCollectionViewDelegate = DetailCollectionViewDelegate()
    private var multipartFormData = MultipartFormData()
    private var observe: NSKeyValueObservation?
    private var product: Product?
    weak var delegate: IndexPathAvailable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        processCollectionView()
        registeredIdetifier()
        setUpContent()
        setUpDataSourceContent()
        setUpNavigationTitle()
        setUpKVO()
        setUpNotification()
    }
    
    override func viewWillTransition(
        to size: CGSize,with coordinator: UIViewControllerTransitionCoordinator) {
            super.viewWillTransition(to: size, with: coordinator)
            
            view.subviews.forEach { $0.removeFromSuperview() }
            setUpContent()
        }
    
    private func setUpContent() {
        view.addSubview(content.scrollView)
        if  UIDevice.current.orientation.isLandscape {
            content.setUpLandscape(view: view)
        } else {
            content.setUpPortrait(view: view)
        }
    }
    
    private func processCollectionView() {
        content.photoCollectionView.dataSource = detailCollectionViewDataSource
        content.photoCollectionView.delegate = detailCollectionViewDelegate
    }
    
    private func registeredIdetifier() {
        content.photoCollectionView.register(DetailPhotoCell.self,
                                             forCellWithReuseIdentifier: DetailPhotoCell.identifier)
    }
    
    private func setUpDataSourceContent() {
        detailCollectionViewDataSource.decidedCollectionViewLayout(content.photoCollectionView)
    }
    
    private func setUpNavigationTitle() {
        content.navigationItemTitle.text = self.title
        self.navigationItem.titleView = content.navigationItemTitle
    }
    
    private func setUpKVO() {
        observe =
        detailCollectionViewDelegate.observe(
            \.currentPageNumber, options: [.new]) { [weak self] _, change in
                if let currentPageNumber = change.newValue {
                    self?.content.setUpCurrentPageNumber(number: currentPageNumber)
                }
            }
    }
    
    private func setUpNotification() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(operateModifyAfter(_:)),
            name: .modifyAfter, object: nil)
    }
    
    @objc func operateModifyAfter(_ notification: Notification) {
        guard let photos = notification.userInfo?["photo"] as? [UIImage],
              let product = product else {
                  return
              }
        requestDetail(id: product.id)
        detailCollectionViewDataSource.updatePhotos(photos: photos)
        content.photoCollectionView.reloadData()
    }
    
    private func requestDetail(id: Int) {
        networkManager.commuteWithAPI(api: GetItemAPI(id: id)) { result in
            if case .success(let data) = result {
                guard let product = try? self.parsingManager.decodedJSONData(type: Product.self, data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.product = product
                    self.content.setUpLabel(product: product)
                }
            }
        }
    }
    
    func setUpDetail(product: Product) {
        self.title = product.title
        self.detailCollectionViewDataSource.requestImage(thumnails: product.thumbnails) { index in
            DispatchQueue.main.async {
                self.content.photoCollectionView.reloadItems(
                    at: [(IndexPath(item: index, section: .zero))])
            }
        }
        requestDetail(id: product.id)
    }
    
    private func requestDelete(password: String) {
        guard let product = product else {
            return
        }
        networkManager.commuteWithAPI(
            api: DeleteAPI(id: product.id, password: password)) { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert(message: "비밀번호가 틀렸습니다")
                    }
                    debugPrint(error.errorDescription)
                case .success:
                    DispatchQueue.main.async {
                        self.showAlert(message: "삭제되었습니다") {
                            self.delegate?.updateDeleteIndexPath()
                            self.navigationController?.popViewController(animated: true)
                            
                        }
                    }
                }
            }
    }
    
    private func checkModifyPassword(password: String) {
        guard let product = product else {
            return
        }
        self.multipartFormData.password = password
        networkManager.commuteWithAPI(api: PatchAPI(id: product.id, parameter: multipartFormData.parameter, image: nil)) { result in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showAlert(message: "비밀번호가 틀렸습니다")
                }
                debugPrint(error.errorDescription)
            case .success:
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: Self.segueModifyIdentifier,
                                      sender: password)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let editViewController = segue.destination as? EditViewController,
              let password = sender as? String,
              let product = product else {
                  return
              }
        editViewController.setUpNavigationTitle(title: EditViewController.modifyTitle)
        editViewController.receiveModifyInformation(
            product: product,
            password: password,
            images: detailCollectionViewDataSource.photos)
    }
    
    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        self.showEditAction { [weak self] password in
            guard let self = self else { return }
            self.requestDelete(password: password)
        } modifyCompletion: { [weak self] password in
            guard let self = self else { return }
            self.checkModifyPassword(password: password)
        }
        
    }
}
