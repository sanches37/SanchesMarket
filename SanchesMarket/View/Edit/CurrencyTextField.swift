//
//  CurrencyTextField.swift
//  SanchesMarket
//
//  Created by tae hoon park on 2022/01/30.
//

import UIKit

class CurrencyTextField: UITextField {
    private let pickerView = UIPickerView()
    private let currencies: [String] = ["", "KRW", "USD"]
    private var selectedCurrency: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpPickerView()
        setUpToolbar()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUpPickerView() {
        pickerView.dataSource = self
        pickerView.delegate = self
        inputView = pickerView
    }
    
    private func setUpToolbar() {
        let toolbar = UIToolbar()
        let leftSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(
            title: "확인", style: .done, target: self, action: #selector(tappedDoneButton))
        toolbar.setItems([leftSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        toolbar.isUserInteractionEnabled = true
        inputAccessoryView = toolbar
    }
    
    @objc private func tappedDoneButton() {
        self.resignFirstResponder()
        inputView = pickerView
    }
    
}

extension CurrencyTextField: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.text = currencies[row]
    }
    
}
