//
//  DetailPhotoCell.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class DetailPhotoCell: UICollectionViewCell {
    static let identifier = String(describing: EditPhotoCell.self)
    let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpPhotoImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        photoImage.frame = bounds
    }
    
    private func setUpPhotoImage() {
        contentView.addSubview(photoImage)
        photoImage.frame = CGRect(x: 0, y: 0,
                                  width: contentView.frame.width,
                                  height: contentView.frame.height)
    }
    
    func configure(photo: UIImage) {
        photoImage.image = photo
    }

}
