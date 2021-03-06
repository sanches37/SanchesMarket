//
//  ProductCell.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/14.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discountedPriceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    static let listIdentifier = "ProductListCell"
    static let gridIdentifier = "ProductGridCell"
    private var imageDataTask: URLSessionDataTask?
    private let maximumStockAount = 999
    private var labelArray: [UILabel] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelArray = [titleLabel, priceLabel, discountedPriceLabel, stockLabel]
        setUpTextWidth()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageDataTask?.cancel()
        thumbnailImage.image = nil
    }
    
    private func resetContents() {
        labelArray.forEach {
            $0.attributedText = nil
            $0.textColor = nil
            $0.text = nil
        }
    }
    
    private func setUpTextWidth() {
        labelArray.forEach {
            $0.adjustsFontSizeToFitWidth = true
        }
    }
    
    func productConfigure(product: Product,
                          identifier: String,
                          imageManager: ImageManager) {
        textConfigure(product: product)
        imageConfigure(product: product, imageManager: imageManager)
        styleConfigure(identifier: identifier)
    }
    
    private func textConfigure(product: Product) {
        resetContents()
        self.titleLabel.text = product.title
        
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
            stockLabel.text = "??????"
            stockLabel.textColor = .systemOrange
        } else if product.stock > self.maximumStockAount {
            stockLabel.text = "???????????? : \(self.maximumStockAount) +"
            stockLabel.textColor = .systemGray
        } else {
            stockLabel.text = "???????????? : \(product.stock)"
            stockLabel.textColor = .systemGray
        }
    }
    
    private func styleConfigure(identifier: String) {
        if identifier == Self.gridIdentifier {
            self.layer.cornerRadius = 10
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.gray.cgColor
        } else {
            self.layer.addBorder(edge: .bottom, color: .gray, thickness: 1)
        }
    }
    
    private func imageConfigure(product: Product, imageManager: ImageManager) {
        if let successImage = product.thumbnails.first {
            imageDataTask = imageManager.fetchImage(url: successImage) { image in
                DispatchQueue.main.async {
                    switch image {
                    case .success(let image):
                        self.thumbnailImage.image = image
                    case .failure(let error):
                        self.thumbnailImage.image = #imageLiteral(resourceName: "LoadedImageFailed")
                        debugPrint(error.errorDescription)
                    }
                }
            }
        }
    }
}
