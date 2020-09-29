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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Public func
    func set(model: Model){
        label.text = model.title
        postFixLabel.text = model.postFix.rawValue
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
        label.font = .boldSystemFont(ofSize: 32)
        
    }
    
    private func setupPostFixLabel(){
        addSubview(postFixLabel)
        
        postFixLabel.translatesAutoresizingMaskIntoConstraints = false
        let bottom = postFixLabel.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: -3)
        let leading  = postFixLabel.leadingAnchor.constraint(equalTo: label.trailingAnchor)
        let trailing = postFixLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([bottom, leading, trailing])
        
        postFixLabel.textColor = .lightDimmedBlue
        postFixLabel.font = .boldSystemFont(ofSize: 16)
    }
}

extension LabelWithPostfix {
    struct Model {
        let title: String
        let postFix: Postfix
    }
    
    enum Postfix: String {
        case min
        case sec
        case exercise
    }
}




































