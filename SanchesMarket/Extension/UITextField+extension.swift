//
//  UITextField+extension.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/29.
//

import UIKit

extension UITextField {
    func addUnderLine(height: CGFloat = 1, color: UIColor = .black) {
        let underLineView = UIView()
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        underLineView.backgroundColor = color
        borderStyle = .none
        addSubview(underLineView)
        
        NSLayoutConstraint.activate([
            underLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            underLineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: height)
        ])
        
    }
}
