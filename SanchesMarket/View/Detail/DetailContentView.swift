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
        setUpPhotoStckViewContent()
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
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    private let photoStackView: UIStackView = {
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
    
    private let photoPageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.hidesForSinglePage = true
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .firstBaseline
        stackView.spacing = 5
        return stackView
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2, compatibleWith: UITraitCollection(legibilityWeight: .bold))
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let stockLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 0
        return stackView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let discountedPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    func setUpPortrait(view: UIView) {
        setUpPortraitScrollView(view: view)
        setUpPortraitContentStackViewContent()
    }
    
    func setUpLandscape(view: UIView) {
        setUpLandscapeScrollView(view: view)
        setUpLandscapePhotoStackView(view: view)
        setUpLandscapeContentStackViewContent()
    }
    
    private func setUpPortraitScrollView(view: UIView) {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpLandscapeScrollView(view: UIView) {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setUpContentStackView() {
        scrollView.addSubview(contentStackView)
        NSLayoutConstraint.activate([
            contentStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            contentStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 8),
            contentStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -16)
        ])
        let bottomHeight = contentStackView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        bottomHeight.priority = .defaultLow
        bottomHeight.isActive = true
    }
    
    private func setUpContentStackViewContent() {
        if UIDevice.current.orientation.isLandscape {
            setUpPortraitContentStackViewContent()
        } else {
            setUpLandscapeContentStackViewContent()
        }
    }
    
    private func setUpPortraitContentStackViewContent() {
        contentStackView.addArrangedSubview(photoStackView)
        contentStackView.addArrangedSubview(titleStackView)
        contentStackView.addArrangedSubview(priceStackView)
        contentStackView.addArrangedSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            titleStackView.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setUpLandscapeContentStackViewContent() {
        contentStackView.addArrangedSubview(titleStackView)
        contentStackView.addArrangedSubview(priceStackView)
        contentStackView.addArrangedSubview(descriptionLabel)
        NSLayoutConstraint.activate([
            titleStackView.heightAnchor.constraint(equalToConstant: 30),
            priceStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        let descriptionHeight = descriptionLabel.heightAnchor.constraint(equalToConstant: 40)
        descriptionHeight.priority = .defaultLow
        descriptionHeight.isActive = true
    }
    
    private func setUpLandscapePhotoStackView(view: UIView) {
        view.addSubview(photoStackView)
        NSLayoutConstraint.activate([
            photoStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, constant: -16),
            photoStackView.trailingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: -8),
            photoStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            photoStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            photoStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -8)
        ])
    }
    
    private func setUpPhotoStckViewContent() {
        photoStackView.addArrangedSubview(photoCollectionView)
        photoStackView.addArrangedSubview(photoPageControl)
        NSLayoutConstraint.activate([
            photoCollectionView.heightAnchor.constraint(
                equalTo: photoStackView.widthAnchor)
        ])
    }
    
    private func setUpTitleStckViewContent() {
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(stockLabel)
        NSLayoutConstraint.activate([
            stockLabel.widthAnchor.constraint(equalToConstant: 100),
            stockLabel.heightAnchor.constraint(equalTo: titleStackView.heightAnchor),
            titleLabel.heightAnchor.constraint(equalTo: titleStackView.heightAnchor)
            ])
    }
    
    private func setUpPriceStackViewContent() {
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(discountedPriceLabel)
    }
    
    func setUpLabel(product: Product) {
        titleLabel.text = product.title
        navigationItemTitle.text = product.title
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
