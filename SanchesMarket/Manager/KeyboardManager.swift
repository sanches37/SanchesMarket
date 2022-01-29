//
//  KeyboardManager.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/30.
//

import UIKit

class KeyboardManager {
    let view: UIView
    let scrollView: UIScrollView
    
    init(view: UIView, scrollView: UIScrollView) {
        self.scrollView = scrollView
        self.view = view
    }
    
    func setUpKeyboard() {
        addKeyboardNotification()
        hideKeyboard()
    }

    private func addKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
                  return
              }
        scrollView.contentInset.bottom = keyboardFrame.cgRectValue.height
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    private func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
