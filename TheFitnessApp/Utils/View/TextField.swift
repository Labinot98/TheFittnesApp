//
//  TextField.swift
//  TheFitnessApp
//
//  Created by MacBook on 26/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class TextField: UITextField {
    /// Allows to perform copy , paste and other actions
    var isActionEnabled = true
    
   private var padding: UIEdgeInsets
    
   private let topShadow = UIView()
   private let leftShadow = UIView()
   private let bottomShadow = UIView()
   private let rightShadow = UIView()
    
    init(padding: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)) {
        self.padding = padding
        super.init(frame: .zero)
        setupTopShadow()
        setupBottomShadow()
        setupLeftShadow()
        setupRightShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTopShadow() {
        addSubview(topShadow)
        
        topShadow.translatesAutoresizingMaskIntoConstraints = false
        let top = topShadow.topAnchor.constraint(equalTo: topAnchor, constant: 0)
        let height = topShadow.heightAnchor.constraint(equalToConstant: 1)
        let leading = topShadow.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = topShadow.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([top, height, leading, trailing])
        
        topShadow.layer.cornerRadius = 3
        topShadow.layer.shadowRadius = 4
        topShadow.layer.shadowColor = UIColor.darkShadow.cgColor
        topShadow.layer.shadowOpacity = 1.0
        topShadow.layer.shadowOffset = CGSize(width:0 , height: 4)
        topShadow.layer.backgroundColor = UIColor.dimmedBlue.cgColor
        topShadow.layer.masksToBounds = false
    }
    
    private func setupBottomShadow() {
        addSubview(bottomShadow)
        
        bottomShadow.translatesAutoresizingMaskIntoConstraints = false
        let top = bottomShadow.topAnchor.constraint(equalTo: bottomAnchor, constant: 1)
        let height = bottomShadow.heightAnchor.constraint(equalToConstant: 1)
        let leading = bottomShadow.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = bottomShadow.trailingAnchor.constraint(equalTo: trailingAnchor)
        NSLayoutConstraint.activate([top, height, leading, trailing])
        
        bottomShadow.layer.cornerRadius = 3
        bottomShadow.layer.shadowRadius = 4
        bottomShadow.layer.shadowColor = UIColor.lightShadow.cgColor
        bottomShadow.layer.shadowOpacity = 1.0
        bottomShadow.layer.shadowOffset = CGSize(width:0 , height: -3)
        bottomShadow.layer.backgroundColor = UIColor.dimmedBlue.cgColor
        bottomShadow.layer.masksToBounds = false
    }
    
    private func setupLeftShadow() {
        addSubview(leftShadow)
        
        leftShadow.translatesAutoresizingMaskIntoConstraints = false
        let top = leftShadow.topAnchor.constraint(equalTo: topAnchor)
        let leading = leftShadow.leadingAnchor.constraint(equalTo: leadingAnchor)
        let bottom = leftShadow.bottomAnchor.constraint(equalTo: bottomAnchor)
        let width = leftShadow.widthAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([top, leading,bottom, width])
        
        leftShadow.layer.cornerRadius = 3
        leftShadow.layer.shadowRadius = 4
        leftShadow.layer.shadowColor = UIColor.darkShadow.cgColor
        leftShadow.layer.shadowOpacity = 1.0
        leftShadow.layer.shadowOffset = CGSize(width: 5 , height: 0)
        leftShadow.layer.backgroundColor = UIColor.dimmedBlue.cgColor
        leftShadow.layer.masksToBounds = false
    }
    
    private func setupRightShadow() {
        addSubview(rightShadow)
        
        rightShadow.translatesAutoresizingMaskIntoConstraints = false
        let top = rightShadow.topAnchor.constraint(equalTo: topAnchor)
        let trailing = rightShadow.trailingAnchor.constraint(equalTo: trailingAnchor)
        let bottom = rightShadow.bottomAnchor.constraint(equalTo: bottomAnchor)
        let width = rightShadow.widthAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([top, trailing, bottom, width])
        
        rightShadow.layer.cornerRadius = 3
        rightShadow.layer.shadowRadius = 4
        rightShadow.layer.shadowColor = UIColor.black.cgColor
        rightShadow.layer.shadowOpacity = 1.0
        rightShadow.layer.shadowOffset = CGSize(width: -5 , height: 0)
        rightShadow.layer.backgroundColor = UIColor.lightShadow.cgColor
        rightShadow.layer.masksToBounds = false
    }
    
    // MARK: Logic
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return isActionEnabled
    }
    
}

// Padding

extension TextField {

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}




































