//
//  EnrollModifyPhotoSelectCell.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/19.
//

import UIKit

class EnrollModifyPhotoSelectCell: UICollectionViewCell {
    static let identifier = String(describing: EnrollModifyPhotoSelectCell.self)
    private let cameraImage = UIImage(systemName: "camera")
    private let photoTotalNumber = 5
    private var photoSelectNumber = 0
    let photoSelectButton: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setup() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
    }
    
    func configure() {
        contentView.addSubview(photoSelectButton)
        photoSelectButton.setTitle(
            "\(photoSelectNumber)/\(photoTotalNumber)", for: .normal)
        photoSelectButton.setImage(cameraImage, for: .normal)
        photoSelectButton.setTitleColor(.black, for: .normal)
        photoSelectButton.tintColor = .black
        photoSelectButton.frame = CGRect(x: 0, y: 0,
                                         width: contentView.frame.width,
                                         height: contentView.frame.height)
    }
}
