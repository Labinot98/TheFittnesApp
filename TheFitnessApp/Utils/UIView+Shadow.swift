//
//  UIView=.swift
//  TheFitnessApp
//
//  Created by MacBook on 26/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

extension UIView {
    // Difrent inner shadow styles
    public enum innerShadowSide {
        case top
        case bottom
        case right
        case left
    }
    
    // define function to add inner shadow
    public func addInnerShadow(
        onSide: innerShadowSide,
        shadowColor: UIColor,
        shadowSize: CGFloat,
        cornerRadius: CGFloat = 0.0,
        shadowOpacity: Float
        ){
        // Define and set a shadow layer
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.shadowColor = shadowColor.cgColor
        shadowLayer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        shadowLayer.shadowOpacity = shadowOpacity
        shadowLayer.shadowRadius = shadowSize
        shadowLayer.fillRule = CAShapeLayerFillRule.evenOdd
        shadowLayer.backgroundColor = UIColor.red.cgColor
        
        //define shadow path
        let shadowPath = CGMutablePath()
        
        //Define outer rectangle to restrict drawing area
        let insetRect = bounds.insetBy(dx: -shadowSize * 2.0, dy: -shadowSize * 2.0)
        
        // Define inner rectangle for mask
        let innerFrame: CGRect = { () -> CGRect in
        switch onSide {
            case .top:
                return CGRect(
                    x: -shadowSize * 2.0,
                    y: 0.0,
                    width: frame.size.width + shadowSize * 4.0,
                    height: frame.size.height + shadowSize * 2.0
                )
            case .bottom:
                return CGRect(
                    x: -shadowSize * 2.0,
                    y: 0.0,
                    width: frame.size.width + shadowSize * 4.0,
                    height: frame.size.height + shadowSize * 2.0
                )
        case .left:
            return CGRect(x: 0.0,
                          y: -shadowSize * 2.0,
                          width: frame.size.width + shadowSize * 2.0,
                          height: frame.size.height + shadowSize * 4.0
                )
        case .right:
            return CGRect(x: -shadowSize * 2.0,
                          y: -shadowSize * 2.0,
                          width: frame.size.width + shadowSize * 2.0,
                          height: frame.size.height + shadowSize * 4.0
                )
            }
            
        }()
    
        // add outer and inner rectangle to shadow path
        shadowPath.addRect(insetRect)
        shadowPath.addRect(innerFrame)
        
        // set shadow path as show layers
        shadowLayer.path = shadowPath
        
        // add shadow layer as a sublayer
        layer.addSublayer(shadowLayer)
        
        // hide outside drawing area
        clipsToBounds = true
        
    }
}

















































