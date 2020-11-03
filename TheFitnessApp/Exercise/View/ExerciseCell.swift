//
//  ExerciseCell.swift
//  TheFitnessApp
//
//  Created by MacBook on 29/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

class ExerciseCell: UITableViewCell {
    
    
    private let containerView = ContainerView()
     private let minLabel = LabelWithPostfix()
    private let  secLabel = LabelWithPostfix()
     private let titleLabel = UILabel()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func set(model: ExerciseModel) {
        titleLabel.text = model.title
        
        let minLabelModel = LabelWithPostfix.Model(title: model.min.description, postFix: .min )
        minLabel.set(model: minLabelModel)
        
        let secLabelModel = LabelWithPostfix.Model(title: model.sec.description, postFix: .sec)
        secLabel.set(model: secLabelModel)
    }
    
    // set function that will also set the timelabel etc...
    
    // MARK: - Private
    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupContainerView()
        setupMinLabel()
        setupSecLabel()
        setupNameLabel()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let top = containerView.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        let leading = containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        let bottom = containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        let trailing = containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        NSLayoutConstraint.activate([top, leading, bottom , trailing])
    }
    
    private func setupMinLabel() {
         containerView.addSubview(minLabel)
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = minLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30)
        let centerY = minLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        NSLayoutConstraint.activate([leading, centerY])
    }
    
    private func setupSecLabel() {
        containerView.addSubview(secLabel)
        
        secLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = secLabel.leadingAnchor.constraint(equalTo: minLabel.trailingAnchor, constant: 15)
        let centerY = secLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        NSLayoutConstraint.activate([leading, centerY])
    }
    
    private func setupNameLabel() {
        containerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = titleLabel.leadingAnchor.constraint(equalTo: secLabel.trailingAnchor, constant: 15)
        let centerY = titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        NSLayoutConstraint.activate([leading, centerY])
        
        titleLabel.textColor = .customWhite
        titleLabel.font = .systemFont(ofSize: 32)
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
}
























































