//
//  NeuTimeTextFieldDelegate.swift
//  TheFitnessApp
//
//  Created by MacBook on 02/11/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

protocol NeuTimeTextFieldDelegate: class {
    func valuesDidChange(to min: Int, sec: Int)
}
