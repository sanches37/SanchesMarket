//
//  ProductCell.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/14.
//

import UIKit

class ProductCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var discontedPriceLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
