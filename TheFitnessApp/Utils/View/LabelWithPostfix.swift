//
//  LabelWithPostfix.swift
//  TheFitnessApp
//
//  Created by MacBook on 09/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class LabelWithPostfix: UIView{
    private let label = UILabel()
    private let postFixLabel = UILabel()
    private var baseLineAdjustment: CGFloat
    private let display: Display
    
    init(labelSize: CGFloat = 32, postFixSize: CGFloat = 16, baseLineAdjustment: CGFloat = -4, display: Display = .lowerCase) {
        self.label.font = .boldSystemFont(ofSize: labelSize)
        self.postFixLabel.font = .boldSystemFont(ofSize: CGFloat(postFixSize))
        self.baseLineAdjustment = baseLineAdjustment
        self.display = display
        
        
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public func
    func set(model: Model){
        if let number = Int(model.title), number < 10 {
            label.text = "0\(number)"
        }else {
          label.text = model.title
        }
        var postFix = model.postFix.rawValue
        switch display {
        case .lowerCase: postFix = postFix.lowercased()
        case .capital: postFix = postFix.uppercased()
        }
        
        postFixLabel.text = postFix
    }
    
    
    // MARK: - Private func
    
    private func debug(){
        label.backgroundColor = .yellow
        postFixLabel.backgroundColor = .blue
    }
    
    private func setupView(){
        setupLabel()
        setupPostFixLabel()
    }
    
    private func setupLabel(){
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let top = label.topAnchor.constraint(equalTo: topAnchor)
        let leading  = label.leadingAnchor.constraint(equalTo: leadingAnchor)
        let bottom = label.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([top, leading, bottom])
        
        label.textColor = .customRed
        
    }
    
    private func setupPostFixLabel(){
        addSubview(postFixLabel)
        
        postFixLabel.translatesAutoresizingMaskIntoConstraints = false
        let bottom = postFixLabel.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: baseLineAdjustment)
        let leading  = postFixLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 3)
        let trailing = postFixLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([bottom, leading, trailing])
        
        postFixLabel.textColor = .lightDimmedBlue
    }
}

extension LabelWithPostfix {
    struct Model {
        let title: String
        let postFix: Postfix
    }
    
    enum Postfix: String {
        case minutes
        case second
        case exercises
    }
    
    enum Display {
        case capital
        case lowerCase
    }
}




































