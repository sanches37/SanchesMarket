//
//  Media.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/05.
//

import UIKit

struct Media {
    let key: String = "images[]"
    let filename: String
    let data: Data
    let mimeType: MimeType
    
    init?(image: UIImage, mimeType: MimeType) {
        switch mimeType {
        case .jpeg:
            guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
            self.data = data
            self.filename = "\(Date()).jpeg"
        case .png:
            guard let data = image.pngData() else { return nil }
            self.data = data
            self.filename = "\(Date()).png"
        }
        
        self.mimeType = mimeType
    }
}
