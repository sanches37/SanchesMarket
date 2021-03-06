//
//  PhotoAlbumCell.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/20.
//

import UIKit

class PhotoAlbumCell: UICollectionViewCell {
    static let identifier = String(describing: PhotoAlbumCell.self)
    private var currentImage: UIImage?
    private var viewArray: [UIView] = []
    let photoAlbumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
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
        viewArray = [photoAlbumImage, highlightIndicator, selectIndicator]
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        viewArray.forEach {
            $0.frame = bounds
        }
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
        highlightIndicator.backgroundColor = .white
        highlightIndicator.alpha = 0.5
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
                equalTo: contentView.trailingAnchor, constant: -5),
            selectIndicator.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: 5),
            selectIndicator.widthAnchor.constraint(equalToConstant: 28),
            selectIndicator.heightAnchor.constraint(
                equalTo: selectIndicator.widthAnchor, multiplier: 1)
        ])
    }
    
    func configure(image: UIImage) {
        self.photoAlbumImage.image = image
        currentImage = image
    }
    
    func getCurrentImage() -> UIImage? {
        return currentImage
    }
}
