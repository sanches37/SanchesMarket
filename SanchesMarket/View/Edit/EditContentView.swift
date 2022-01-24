//
//  EditContentView.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/25.
//

import UIKit

class EditContentView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpVerticalStackView()
        setUpSteckViewAddSubView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
        
    }()
    
    private let verticalStacView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    let photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isDirectionalLockEnabled = true
        return collectionView
    }()
    
    func setUpScrollView(view: UIView) {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpVerticalStackView() {
        scrollView.addSubview(verticalStacView)
        NSLayoutConstraint.activate([
            verticalStacView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            verticalStacView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            verticalStacView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            verticalStacView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            verticalStacView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
            verticalStacView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        ])
    }
    
    private func setUpSteckViewAddSubView() {
//        photoCollectionView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        verticalStacView.addArrangedSubview(photoCollectionView)
    }
}
