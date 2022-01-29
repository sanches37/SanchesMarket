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
        return collectionView
    }()
    
    let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .body)
        textField.addLeftPadding()
        textField.addUnderLine()
        textField.placeholder = "상품명"
        textField.keyboardType = .default
        return textField
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
    
    let currencyTextField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .body)
        textField.addLeftPadding()
        textField.addUnderLine()
        textField.placeholder = "화폐단위"
        textField.keyboardType = .default
        return textField
    }()
    
    let priceTextField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .body)
        textField.addLeftPadding()
        textField.addUnderLine()
        textField.placeholder = "가격"
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let discountedPriceTextField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .body)
        textField.addLeftPadding()
        textField.addUnderLine()
        textField.placeholder = "할인가격"
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    let stockTextField: UITextField = {
        let textField = UITextField()
        textField.font = .preferredFont(forTextStyle: .body)
        textField.addLeftPadding()
        textField.addUnderLine()
        textField.placeholder = "재고수량"
        textField.keyboardType = .numberPad
        return textField
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.text = "상세설명"
        textView.textColor = UIColor.gray.withAlphaComponent(0.5)
        textView.keyboardType = .default
        textView.isScrollEnabled = false
        return textView
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
        verticalStacView.addArrangedSubview(titleTextField)
        verticalStacView.addArrangedSubview(horizontalStacView)
        verticalStacView.addArrangedSubview(discountedPriceTextField)
        verticalStacView.addArrangedSubview(stockTextField)
        verticalStacView.addArrangedSubview(descriptionTextView)
        setUpPhotoCollectionViewConstraint()
        NSLayoutConstraint.activate([
            titleTextField.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 1/8),
            horizontalStacView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 1/8),
            discountedPriceTextField.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 1/8),
            stockTextField.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor, multiplier: 1/8),
            descriptionTextView.bottomAnchor.constraint(equalTo: verticalStacView.bottomAnchor)
        ])
        let descriptionTextViewInitSize = descriptionTextView.heightAnchor.constraint(equalToConstant: 80)
        descriptionTextViewInitSize.priority = .defaultLow
        descriptionTextViewInitSize.isActive = true
    }
    
    func setUpPhotoCollectionViewConstraint() {
        if  UIDevice.current.orientation.isLandscape {
            photoCollectionView.heightAnchor.constraint(
                equalTo: verticalStacView.widthAnchor, multiplier: 1/8).isActive = true
        } else {
            photoCollectionView.heightAnchor.constraint(
                equalTo: verticalStacView.widthAnchor, multiplier: 1/3).isActive = true
        }
    }
    
    private func setUpHorizontalStckViewContent() {
        horizontalStacView.addArrangedSubview(currencyTextField)
        horizontalStacView.addArrangedSubview(priceTextField)
        NSLayoutConstraint.activate([
            currencyTextField.widthAnchor.constraint(equalToConstant: 100)
        ])
    }
}
