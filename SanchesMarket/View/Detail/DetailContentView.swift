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
        
        setUpContentStackView()
        setUpContentStackViewContent()
        setUpTitleStckViewContent()
        setUpPriceStackViewContent()
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
    
    let navigationItemTitle: UILabel = {
        let label = UILabel(
            frame: CGRect(x: .zero, y: .zero, width: 100, height: 100))
        label.textColor = UIColor.black
        label.font = .preferredFont(forTextStyle: .title2, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        return label
    }()
    
    let contentStacView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 15
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
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.hidesForSinglePage = true
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .firstBaseline
        stackView.spacing = 2
        return stackView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let stockLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .justified
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
    
    private func setUpContentStackView() {
        scrollView.addSubview(contentStacView)
        NSLayoutConstraint.activate([
            contentStacView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            contentStacView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 8),
            contentStacView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentStacView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStacView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStacView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16)
        ])
        let bottomHeight = contentStacView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        bottomHeight.priority = .defaultLow
        bottomHeight.isActive = true
    }
    
    private func setUpContentStackViewContent() {
        contentStacView.addArrangedSubview(photoCollectionView)
        contentStacView.addArrangedSubview(photoPageControl)
        contentStacView.addArrangedSubview(titleStackView)
        contentStacView.addArrangedSubview(priceStackView)
        contentStacView.addArrangedSubview(descriptionLabel)
        setUpPhotoCollectionViewConstraint()
        NSLayoutConstraint.activate([
            titleStackView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func setUpPhotoCollectionViewConstraint() {
        if  UIDevice.current.orientation.isLandscape {
            photoCollectionView.heightAnchor.constraint(
                equalTo: contentStacView.widthAnchor).isActive = true
        } else {
            photoCollectionView.heightAnchor.constraint(
                equalTo: contentStacView.widthAnchor).isActive = true
        }
    }
    
    private func setUpTitleStckViewContent() {
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(stockLabel)
        NSLayoutConstraint.activate([
            stockLabel.widthAnchor.constraint(equalTo: contentStacView.widthAnchor, multiplier: 1/3)
        ])
    }
    
    private func setUpPriceStackViewContent() {
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(discountedPriceLabel)
    }
    
    func setUpLabel(product: Product) {
        titleLabel.text = product.title
        photoPageControl.numberOfPages = product.thumbnails.count
        if product.stock == .zero {
            stockLabel.text = "품절"
            stockLabel.textColor = .systemOrange
        } else if product.stock > self.maximumStockAount {
            stockLabel.text = "수량 : \(self.maximumStockAount) +"
            stockLabel.textColor = .systemGray
        } else {
            stockLabel.text = "수량 : \(product.stock)"
            stockLabel.textColor = .systemGray
        }
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
        descriptionLabel.text = product.descriptions
    }
    
    func setUpCurrentPageNumber(number: Int) {
        photoPageControl.currentPage = number
    }
}
