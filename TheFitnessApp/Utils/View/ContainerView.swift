//
//  ContainerView.swift
//  TheFitnessApp
//
//  Created by MacBook on 08/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class ContainerView: UIView {
    private let upperShadowView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupView() {
//        translatesAutoresizingMaskIntoConstraints = false
//        heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        layer.cornerRadius = 10
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.darkShadow.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 3, height: 3)
        layer.backgroundColor = UIColor.dimmedBlue.cgColor
        layer.masksToBounds = false
        
        setupUpperShadowView()
    }
    
    private func setupUpperShadowView(){
       addSubview(upperShadowView)
        
        upperShadowView.translatesAutoresizingMaskIntoConstraints = false
        let top = upperShadowView.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        let leading = upperShadowView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        let bottom = upperShadowView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        let trailing = upperShadowView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
         NSLayoutConstraint.activate([top, leading, bottom , trailing])
        
       
        upperShadowView.layer.cornerRadius = 10
        upperShadowView.layer.shadowRadius = 4
         upperShadowView.layer.shadowColor = UIColor.lightShadow.cgColor
        upperShadowView.layer.shadowOpacity = 0.8
        upperShadowView.layer.shadowOffset = CGSize(width: -3, height: -3)
        upperShadowView.layer.backgroundColor = UIColor.dimmedBlue.cgColor
        upperShadowView.layer.masksToBounds = false
    }
    

}





















































