//
//  ViewController.swift
//  TheFitnessApp
//
//  Created by MacBook on 07/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class WorkoutVC: UIViewController {
    var safeArea: UILayoutGuide!
    
    let cardView = CardView()

    override func viewDidLoad() {
        super.viewDidLoad()
 
            setupView()
    }
    
    private func setupView() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .dimmedBlue
        setupTableView()
        setupContainerView()
        setupNavigation()
    }
    
    private func setupTableView(){
        
    }
    
    
    private func setupNavigation(){
        navigationItem.title = "Workout"
    }
    
    private func setupContainerView(){
       view.addSubview(cardView)
        
        cardView.translatesAutoresizingMaskIntoConstraints = false
        let top = cardView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 15)
        let leading = cardView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        let trailing = cardView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        let height = cardView.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([top, leading, trailing, height])
        
       cardView.layer.cornerRadius = 10
    }

}




















































