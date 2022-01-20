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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func photoAlbumImageSetup() {
        contentView.addSubview(photoAlbumImage)
        photoAlbumImage.layer.cornerRadius = 10
        photoAlbumImage.layer.borderWidth = 1
        photoAlbumImage.layer.borderColor = UIColor.black.cgColor
        photoAlbumImage.layer.masksToBounds = true
        photoAlbumImage.frame = CGRect(x: 0, y: 0,
                                       width: contentView.frame.width,
                                       height: contentView.frame.height)
    }
    
    private func deleteImageSetup(deletButton: UIButton) {
        contentView.addSubview(deletButton)
        deletButton.translatesAutoresizingMaskIntoConstraints = false
        deletButton.setBackgroundImage(UIImage(systemName: "multiply.circle.fill"),
                                       for: .normal)
        deletButton.tintColor = .black
        deletButton.backgroundColor = .white
        deletButton.layer.cornerRadius = 22
        NSLayoutConstraint.activate([
            deletButton.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor, constant: 3),
            deletButton.topAnchor.constraint(
                equalTo: contentView.topAnchor, constant: -3),
            deletButton.widthAnchor.constraint(equalToConstant: 22),
            deletButton.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configure(image: UIImage, button: UIButton) {
        self.photoAlbumImage.image = image
        deleteImageSetup(deletButton: button)
    }
}
