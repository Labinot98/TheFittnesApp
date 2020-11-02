//
//  NeuTimeTextField.swift
//  TheFitnessApp
//
//  Created by MacBook on 24/10/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class NeuTimeTextField: UIView {
    private let minLabel = UILabel()
    private let minTF = TextField()
    
    private let secLabel = UILabel()
    private let secTF = TextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        setupMinLabel()
        setupMinTF()
        setupSecLabel()
        setupSecTF()
    }
    
    // Minute View
    private func setupMinLabel() {
        addSubview(minLabel)
        
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = minLabel.topAnchor.constraint(equalTo: topAnchor)
        let leading = minLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let width = minLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2)
        NSLayoutConstraint.activate([top, leading, width])
        
        minLabel.text = "min"
        minLabel.textColor = .customWhite
        minLabel.font = .boldSystemFont(ofSize: 24)
    }
    
    private func setupMinTF() {
        addSubview(minTF)
        minTF.translatesAutoresizingMaskIntoConstraints = false
        let top = minTF.topAnchor.constraint(equalTo: minLabel.bottomAnchor, constant: 10)
        let leading = minTF.leadingAnchor.constraint(equalTo: leadingAnchor)
        let height = minTF.heightAnchor.constraint(equalToConstant: 60)
        let width = minTF.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2)
        
        NSLayoutConstraint.activate([top, leading, height, width])
        
        minTF.text = "0"
        minTF.font = .boldSystemFont(ofSize: 28)
        minTF.textColor = .customWhite
        
        let minPicker = UIPickerView()
         minPicker.tag = Tag.min.rawValue
        minPicker.dataSource = self
        minPicker.delegate = self
        minTF.inputView = minPicker
//        minPicker.backgroundColor = .dimmedBlue
        minTF.inputAccessoryView = buildToolbar()
        
    }
    // Second View
    private func setupSecLabel() {
        addSubview(secLabel)
        
        secLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = secLabel.topAnchor.constraint(equalTo: topAnchor)
        let leading = secLabel.leadingAnchor.constraint(equalTo: minLabel.trailingAnchor)
        let width = secLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2)
        NSLayoutConstraint.activate([top, leading, width])
        
        secLabel.text = "sec"
        secLabel.textColor = .customWhite
        secLabel.font = .boldSystemFont(ofSize: 24)
    }
    
    private func setupSecTF() {
        addSubview(secTF)
        secTF.translatesAutoresizingMaskIntoConstraints = false
        let top = secTF.topAnchor.constraint(equalTo: secLabel.bottomAnchor, constant: 10)
        let leading = secTF.leadingAnchor.constraint(equalTo: minTF.trailingAnchor)
        let height = secTF.heightAnchor.constraint(equalToConstant: 60)
        let width = secTF.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2)
        let bottom = secTF.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        NSLayoutConstraint.activate([top, leading, height, width, bottom])
        
        secTF.text = "0"
        secTF.font = .boldSystemFont(ofSize: 28)
        secTF.textColor = .customWhite
        
        let secPicker = UIPickerView()
        secPicker.tag = Tag.sec.rawValue
        secPicker.dataSource = self
        secPicker.delegate = self
        secTF.inputView = secPicker
//        secPicker.backgroundColor = .dimmedBlue
        
    
        secTF.inputAccessoryView = buildToolbar()
        minTF.inputAccessoryView = buildToolbar()
        
    }
    
    // MARK: - Action
    @objc private func doneAction() {
        endEditing(true)
    }
    private func buildToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        let btn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneAction))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([flexibleSpace ,btn], animated: true)
        toolbar.sizeToFit()
        
        return toolbar
    }
    
}


extension NeuTimeTextField: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case Tag.min.rawValue: return 61
        case Tag.sec.rawValue: return 12
        default: return 0
        }
//        if pickerView.tag == Tag.min.rawValue { return 61 }
//        if pickerView.tag == Tag.sec.rawValue { return 12 }
    }
}
extension NeuTimeTextField: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case Tag.min.rawValue: return row.description
        case Tag.sec.rawValue: return (row * 5).description
        default: return 0.description
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case Tag.min.rawValue: minTF.text = row.description
        case Tag.sec.rawValue: secTF.text = (row * 5).description
        default: return
        }
    }
}

extension NeuTimeTextField {
    enum Tag: Int {
        case min
        case sec
    }
}

















































