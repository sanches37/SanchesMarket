//
//  DetailContentView.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class DetailContentView: UIView {
    private let maximumStockAount = 999
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpVerticalStackView()
        setUpVerticalStackViewContent()
        setUpHorizontalStckViewContent()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    let verticalStacView: UIStackView = {
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
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isDirectionalLockEnabled = true
        collectionView.isPagingEnabled = true
        return collectionView
    }()
    
    let photoPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .blue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.hidesForSinglePage = true
        return pageControl
    }()
    
    let horizontalStacView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let stockLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
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
            verticalStacView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 5),
            verticalStacView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            verticalStacView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            verticalStacView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            verticalStacView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -5)
        ])
        let bottomHeight = verticalStacView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        bottomHeight.priority = .defaultLow
        bottomHeight.isActive = true
    }
    
    private func setUpVerticalStackViewContent() {
        verticalStacView.addArrangedSubview(photoCollectionView)
        verticalStacView.addArrangedSubview(horizontalStacView)
        verticalStacView.addArrangedSubview(priceLabel)
        verticalStacView.addArrangedSubview(discountedPriceLabel)
        verticalStacView.addArrangedSubview(descriptionLabel)
        setUpPhotoCollectionViewConstraint()
        NSLayoutConstraint.activate([
            horizontalStacView.heightAnchor.constraint(equalToConstant: 20),
            priceLabel.heightAnchor.constraint(equalToConstant: 20),
            discountedPriceLabel.heightAnchor.constraint(equalToConstant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: discountedPriceLabel.bottomAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: verticalStacView.bottomAnchor)
        ])
    }
    
    func setUpPhotoCollectionViewConstraint() {
        if  UIDevice.current.orientation.isLandscape {
            photoCollectionView.heightAnchor.constraint(
                equalTo: verticalStacView.widthAnchor).isActive = true
        } else {
            photoCollectionView.heightAnchor.constraint(
                equalTo: verticalStacView.heightAnchor, multiplier: 1/2).isActive = true
        }
    }
    
    private func setUpHorizontalStckViewContent() {
        horizontalStacView.addArrangedSubview(titleLabel)
        horizontalStacView.addArrangedSubview(stockLabel)
        horizontalStacView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    func setUpLabel(product: Product) {
        if let discountedPrice = product.discountedPrice {
            priceLabel.attributedText =
            "\(product.currency) \(product.price.withComma)".strikeThrough
            priceLabel.textColor = .systemRed
            discountedPriceLabel.text =
            "\(product.currency) \(discountedPrice.withComma)"
            discountedPriceLabel.textColor = .systemGray
        } else {
            priceLabel.text = "\(product.currency) \(product.price.withComma)"
            priceLabel.textColor = .systemGray
        }

        if product.stock == .zero {
            stockLabel.text = "품절"
            stockLabel.textColor = .systemOrange
        } else if product.stock > self.maximumStockAount {
            stockLabel.text = "잔여수량 : \(self.maximumStockAount) +"
            stockLabel.textColor = .systemGray
        } else {
            stockLabel.text = "잔여수량 : \(product.stock)"
            stockLabel.textColor = .systemGray
        }
    }
}
