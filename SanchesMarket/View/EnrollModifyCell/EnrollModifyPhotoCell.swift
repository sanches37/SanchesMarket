//
//  EnrollModifyPhotoCell.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/20.
//

import UIKit

class EnrollModifyPhotoCell: UICollectionViewCell {
    static let identifier = String(describing: EnrollModifyPhotoCell.self)
    let photoAlbumImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleToFill
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpPhotoAlbumImage()
        setUpDeleteImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpPhotoAlbumImage() {
        contentView.addSubview(photoAlbumImage)
        photoAlbumImage.layer.cornerRadius = 10
        photoAlbumImage.layer.borderWidth = 1
        photoAlbumImage.layer.borderColor = UIColor.black.cgColor
        photoAlbumImage.layer.masksToBounds = true
        photoAlbumImage.frame = CGRect(x: 0, y: 0,
                                       width: contentView.frame.width,
                                       height: contentView.frame.height)
    }
    
    private func setUpDeleteImage() {
        contentView.addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.setBackgroundImage(UIImage(systemName: "multiply.circle.fill"),
                                       for: .normal)
        deleteButton.tintColor = .black
        deleteButton.backgroundColor = .white
        deleteButton.layer.cornerRadius = 22
        NSLayoutConstraint.activate([
            deleteButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: 3),
            deleteButton.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: -3),
            deleteButton.widthAnchor.constraint(equalToConstant: 22),
            deleteButton.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configure(image: UIImage) {
        self.photoAlbumImage.image = image
    }
}
