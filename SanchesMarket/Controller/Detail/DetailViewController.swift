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
            \.currentPageNumber, options: [.new]) {  _, change in
            if let currentPageNumber = change.newValue {
                self.content.setUpCurrentPageNumber(number: currentPageNumber)
            }
        }
    }
    
    private func requestDetail(id: Int) {
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
    
    func setUpDetail(product: Product) {
        self.product = product
        self.title = product.title
        detailCollectionViewDataSource.setUpPhotos(thumbnails: product.thumbnails)
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
                    print(error.errorDescription)
                    DispatchQueue.main.async {
                        self.showAlert(message: "비밀번호가 틀렸습니다")
                    }
                case .success:
                    DispatchQueue.main.async {
                        self.showAlert(message: "삭제되었습니다") {
                            self.delegate?.updateDeleteIndexPath {
                                self.navigationController?.popViewController(animated: true)
                            }
                        }
                    }
                }
            }
    }
    
    private func checkModifyPassword(completion: @escaping (Bool)->Void) {
        guard let product = product else {
            return
        }
        networkManager.commuteWithAPI(api: PatchAPI(id: product.id, parameter: multipartFormData.parameter, image: nil)) { result in
            switch result {
            case .failure(let error):
                print(error.errorDescription)
                DispatchQueue.main.async {
                    self.showAlert(message: "비밀번호가 틀렸습니다")
                }
                completion(false)
            case .success:
                completion(true)
            }
        }
    }
    
    @IBAction func actionButton(_ sender: UIBarButtonItem) {
        self.showDetailAction { password in
            self.requestDelete(password: password)
        } modifyCompletion: { password in
            self.multipartFormData.password = password
            self.checkModifyPassword { result in
                print(result)
            }
        }

    }
}
