//
//  NeuTextField.swift
//  TheFitnessApp
//
//  Created by MacBook on 20/10/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class NeuTextField: UIView {
    var text: String?
    
    private let titleLabel = UILabel()
    private let nameTF = TextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    
    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        setupView()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func set(title: String) {
        text = title
        nameTF.text = title
    }
    
    //MARK: - Private
    
    private func setupView() {
        setupTitleLabel()
        setupNameTextField()
    }
    
    private func setupTitleLabel(){
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = titleLabel.topAnchor.constraint(equalTo: topAnchor)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([top, leading, trailing])
        
//        titleLabel.text = "Name"
        titleLabel.textColor = .customWhite
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
    }
    
    private func setupNameTextField() {
        
        addSubview(nameTF)
        
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        let top = nameTF.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        let leading = nameTF.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = nameTF.trailingAnchor.constraint(equalTo: trailingAnchor)
        let height = nameTF.heightAnchor.constraint(equalToConstant: 60)
        let bottom = nameTF.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([top, leading, trailing, height, bottom])
        
        //        nameTF.backgroundColor = .customWhite
        nameTF.layer.cornerRadius = 10
        nameTF.font = .systemFont(ofSize: 26)
        nameTF.textColor = .customWhite
        //        nameTF.placeholder = "Type Exercise"
        //        nameTF.attributedPlaceholder = NSAttributedString(string: "Type Exercise", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nameTF.returnKeyType = .done
        nameTF.addTarget(self, action: #selector(textFieldAction), for: .editingChanged)
        nameTF.delegate = self
        
    }
    
    @objc func textFieldAction(_ textField: UITextField) {
        text = textField.text
    }
}

extension NeuTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}























































