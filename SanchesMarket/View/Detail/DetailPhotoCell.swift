//
//  DetailPhotoCell.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/02/01.
//

import UIKit

class DetailPhotoCell: UICollectionViewCell {
    static let identifier = String(describing: EditPhotoCell.self)
    private var imageDataTask: URLSessionDataTask?
    let photoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpPhotoImage()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageDataTask?.cancel()
        photoImage.image = nil
    }
    
    private func setUpPhotoImage() {
        contentView.addSubview(photoImage)
        photoImage.frame = CGRect(x: 0, y: 0,
                                  width: contentView.frame.width,
                                  height: contentView.frame.height)
    }
    
    func photoConfigure(thumnail: String, imageManager: ImageManager) {
        imageDataTask = imageManager.fetchImage(url: thumnail) { image in
            DispatchQueue.main.async {
                switch image {
                case .success(let image):
                    self.photoImage.image = image
                case .failure:
                    self.photoImage.image = #imageLiteral(resourceName: "LoadedImageFailed")
                }
            }
        }
    }
}
