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
     private let timeLabel = LabelWithPostfix()
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
        let timeLabelModel = LabelWithPostfix.Model(title: "23", postFix: .sec )
        timeLabel.set(model: timeLabelModel)
        
    }
    
    // set function that will also set the timelabel etc...
    
    // MARK: - Private
    private func setupView() {
        backgroundColor = .clear
        selectionStyle = .none
        
        setupContainerView()
        setupTimeLabel()
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
    
    private func setupTimeLabel() {
         containerView.addSubview(timeLabel)
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = timeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 30)
        let centerY = timeLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        NSLayoutConstraint.activate([leading, centerY])
        
        timeLabel.set(model: LabelWithPostfix.Model(title: "45", postFix: .sec))
    }
    
    private func setupNameLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let leading = titleLabel.leadingAnchor.constraint(equalTo: timeLabel.trailingAnchor, constant: 15)
        let centerY = titleLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        NSLayoutConstraint.activate([leading, centerY])
        
        titleLabel.text = "Bicyle"
        titleLabel.textColor = .customWhite
        titleLabel.font = .systemFont(ofSize: 32)
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
}
























































