//
//  CardView.swift
//  TheFitnessApp
//
//  Created by MacBook on 08/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit
final class CardView: UIView {
    private let containerView = ContainerView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let timeLabel = LabelWithPostfix()
    private let exerciseLabel = LabelWithPostfix()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        setupContainerView()
        setupStackView()
        setupTitleLabel()
        setupTimeLabel()
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        let top = containerView.topAnchor.constraint(equalTo: topAnchor)
        let leading = containerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        let bottom = containerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        let trailing = containerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([top, leading, bottom , trailing])
    }
    
    private func setupStackView() {
        containerView.addSubview(stackView)
        
          stackView.translatesAutoresizingMaskIntoConstraints = false
        let height = stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 2/3)
        let leading = stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15)
        let trailing = stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
         let centerY = stackView.centerYAnchor.constraint(equalTo: centerYAnchor)
        NSLayoutConstraint.activate([height, centerY, leading, trailing])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
    }
    
    private func setupTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
        
        titleLabel.text = "20 Minute Workout"
        titleLabel.textColor = .customWhite
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.backgroundColor = .clear
    }
    
    private func setupTimeLabel() {
        let container = UIView()
        stackView.addArrangedSubview(container)
        
        container.addSubview(timeLabel)
        container.addSubview(exerciseLabel)
        
        let _ = {
            timeLabel.translatesAutoresizingMaskIntoConstraints = false
            let top = timeLabel.topAnchor.constraint(equalTo: container.topAnchor)
            let leading = timeLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor)
            let height = timeLabel.heightAnchor.constraint(equalTo: container.heightAnchor)
            NSLayoutConstraint.activate([top, leading, height])
             timeLabel.set(model: LabelWithPostfix.Model(title: "22", postFix: .min))
        }()
        
        let _ = {
            self.exerciseLabel.translatesAutoresizingMaskIntoConstraints = false
            let top = exerciseLabel.topAnchor.constraint(equalTo: container.topAnchor)
            let leading = exerciseLabel.leadingAnchor.constraint(equalTo: self.timeLabel.trailingAnchor, constant: 15)
            let height = exerciseLabel.heightAnchor.constraint(equalTo: container.heightAnchor)
            NSLayoutConstraint.activate([top, leading, height])
            
            exerciseLabel.set(model: LabelWithPostfix.Model(title: "8", postFix: .exercise))
        }()
    }
}



































































