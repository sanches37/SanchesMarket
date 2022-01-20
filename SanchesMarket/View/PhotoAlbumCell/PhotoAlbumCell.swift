//
//  PhotoAlbumCell.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/20.
//

import UIKit

class PhotoAlbumCell: UICollectionViewCell {
    static let identifier = String(describing: PhotoAlbumCell.self)
    let photoAlbumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let highlightIndicator: UIView = {
        let image = UIView()
            image.contentMode = .scaleToFill
            return image
    }()
    
    let selectIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpPhotoAlbumImage()
        setUpHighlightIndicator()
        setUpSelectIndicator()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpPhotoAlbumImage() {
        contentView.addSubview(photoAlbumImage)
        photoAlbumImage.frame = CGRect(x: .zero, y: .zero,
                                       width: contentView.frame.width,
                                       height: contentView.frame.height)
    }
    
    private func setUpHighlightIndicator() {
        contentView.addSubview(highlightIndicator)
        highlightIndicator.isHidden = true
        highlightIndicator.frame = CGRect(x: .zero, y: .zero,
                                          width: contentView.frame.width,
                                          height: contentView.frame.height)
    }
    
    private func setUpSelectIndicator() {
        contentView.addSubview(selectIndicator)
        selectIndicator.translatesAutoresizingMaskIntoConstraints = false
        selectIndicator.image = UIImage(systemName: "checkmark.circle")
        selectIndicator.isHidden = true
        NSLayoutConstraint.activate([
            selectIndicator.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: 8),
            selectIndicator.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: -8),
            selectIndicator.widthAnchor.constraint(equalToConstant: 25),
            selectIndicator.heightAnchor.constraint(
                equalTo: selectIndicator.widthAnchor, multiplier: 1)
        ])
    }
    
    func configure(image: UIImage) {
        self.photoAlbumImage.image = image
    }
}
