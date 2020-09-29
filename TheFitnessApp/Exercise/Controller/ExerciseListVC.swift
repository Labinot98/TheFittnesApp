//
//  ExerciseListVC.swift
//  TheFitnessApp
//
//  Created by MacBook on 29/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class ExerciseListVC: UIViewController {
    
    
    private var safeArea: UILayoutGuide!
    private let tableView = UITableView()
    private let list = ["Pashant", "Labinot", "Sara", "Ios Dev", "Rocky"]
    
    let workout: WorkoutModel
    
    init(workout: WorkoutModel) {
        self.workout = workout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        setupView()
    }
    
    private func setupView() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .dimmedBlue
        setupNavigtaion()
        setupTableView()
    }
    
    private func setupNavigtaion() {
        navigationItem.title = workout.title
        let addButton = UIBarButtonItem(
            title: "Add",
            style: .done,
            target: self,
            action: #selector (addAction)
        )
        addButton.tintColor = .customRed
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let top = tableView.topAnchor.constraint(equalTo: safeArea.topAnchor)
        let leading = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let bottom = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let trailing = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([top, leading, bottom, trailing])
        
        tableView.backgroundColor = .dimmedBlue
        // register cell
        tableView.register(ExerciseCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    @objc func addAction() {
        print("Addedddd")
    }
}

extension ExerciseListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let name = list[indexPath.row]
        cell.textLabel?.text = name
        return cell
    }
}

extension ExerciseListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
}
















































