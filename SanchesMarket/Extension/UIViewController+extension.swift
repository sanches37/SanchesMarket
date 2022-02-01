//
//  UIViewController+extension.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/23.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func showEditAction() {
        let alert = UIAlertController()
        let enroll = UIAlertAction(
            title: "등록", style: .default) { _ in
                self.performSegue(withIdentifier: MainViewController.segueEditIdentifier, sender: "등록")
            }
        let modify = UIAlertAction(
            title: "수정", style: .default) { _ in
                self.performSegue(withIdentifier: MainViewController.segueEditIdentifier, sender: "수정")
            }
        let cancel = UIAlertAction(
            title: "취소", style: .cancel, handler: nil)
        alert.addAction(enroll)
        alert.addAction(modify)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func setUpPasswordAlert(completion: @escaping (String) -> Void) {
        let alert = UIAlertController(title: "비밀번호를 입력해주세요", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(
            title: "취소", style: .cancel, handler: nil)
        let enroll = UIAlertAction(
            title: "등록", style: .default) { ok in
                guard let password = alert.textFields?.first?.text else {
                    return
                }
                completion(password)
            }
        enroll.isEnabled = false
        alert.addTextField { textField in
            NotificationCenter.default.addObserver(
                forName: UITextField.textDidChangeNotification,
                object: textField, queue: OperationQueue.main) { _ in
                let textCount = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines).count ?? 0
                let textIsNotEmpty = textCount > 0
                enroll.isEnabled = textIsNotEmpty
            }
        }
        alert.addAction(enroll)
        alert.addAction(cancel)
        present(alert, animated: true)
        
    }
}
