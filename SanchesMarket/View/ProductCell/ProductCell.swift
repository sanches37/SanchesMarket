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
    
    private let imageManager = ImageManager()
    private let maximumStockAount = 999
    static let listIdentifier = "ProductListCell"
    static let listNibName = "ProductListCell"
    private var labelArray: [UILabel] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelArray = [titleLabel, priceLabel, discountedPriceLabel, stockLabel]
        setUpTextWidth()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
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
    
    func productConfigure(product: Product) {
        textConfigure(product: product)
        imageConfigure(product: product)
        styleConfigure()
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
    
    private func styleConfigure() {
        self.layer.addBorder(edge: .bottom, color: .gray, thickness: 1)
    }
    
    private func imageConfigure(product: Product) {
        if let successImage = product.thumbnails.first {
            imageManager.fetchImage(url: successImage) { image in
                DispatchQueue.main.async {
                    switch image {
                    case .success(let image):
                        self.thumbnailImage.image = image
                    case .failure:
                        self.thumbnailImage.image = #imageLiteral(resourceName: "LoadedImageFailed")
                    }
                }
            }
        }
    }
}
