//
//  SaveCancelButtons.swift
//  TheFitnessApp
//
//  Created by MacBook on 25/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class SaveCancelButtons: UIView {
    var delegate: SaveCancelButtonDelegate?
    
    private let stackView = UIStackView()
    private let cancelButton = UIButton()
    private let saveButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
       setupStackView()
        setupCancelButton()
        setupSaveButton()
    }
    
    private func setupStackView(){
        addSubview(stackView)
   
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let top = stackView.topAnchor.constraint(equalTo: topAnchor)
        let leading = stackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let bottoom = stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let trailing = stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([top, leading, bottoom, trailing])
        
        stackView.distribution = .fillEqually
        
    }
    
    private func setupCancelButton() {
       stackView.addArrangedSubview(cancelButton)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.setTitleColor(.customRed, for: .normal)
        cancelButton.titleLabel?.font = .boldSystemFont(ofSize: 28)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
    }
    
    private func setupSaveButton() {
        stackView.addArrangedSubview(saveButton)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.customGreen, for: .normal)
        saveButton.titleLabel?.font = .boldSystemFont(ofSize: 28)
        saveButton.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
    }
    
    
    // MARK: - Actions
    
    @objc private func cancelAction() {
        if let delegate = delegate {
            delegate.onCancel()
        }
    }
    
    @objc private func saveAction() {
        if let delegate = delegate {
            delegate.onSave()
        }
    }
}

protocol SaveCancelButtonDelegate {
    func onCancel()
    func onSave()
}
