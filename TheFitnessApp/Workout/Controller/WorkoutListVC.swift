//
//  ViewController.swift
//  TheFitnessApp
//
//  Created by MacBook on 07/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class WorkoutListVC: UIViewController {
    private let workoutDispatcher = try? WorkoutDispatcher()
   private var safeArea: UILayoutGuide!
   private let tableView = UITableView()
    
    var workoutList = ListWorkoutResponse(list: [])

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
            setupView()
        self.tableView.separatorStyle = .none
    }
    
    private func setupView() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .dimmedBlue
        
        setupTableView()
        setupNavigation()
        
    }
    
    
    private func setupNavigation(){
        navigationItem.title = "Workout"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customWhite]
        navigationController?.navigationBar.barTintColor = .dimmedBlue
        navigationController?.navigationBar.isTranslucent = false
        
        let addButton = UIBarButtonItem(
            title: "Add",
            style: .done,
            target: self,
            action: #selector(addAction))
        addButton.tintColor = .customRed
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    
    
    
    private func setupTableView(){
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let top = tableView.topAnchor.constraint(equalTo: safeArea.topAnchor)
        let leading = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let bottom = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let trailing = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([top, leading, bottom, trailing])
        
        tableView.backgroundColor = .dimmedBlue
        // register cell
        tableView.register(WorkoutCell.self, forCellReuseIdentifier: "cellid")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Logic
    private func setupData() {
       
        guard let dispatcher = workoutDispatcher else {
            print("\(self): dispatcehr was nil.")
            return
        }
       workoutList = dispatcher.list(request: ListWorkoutRequest())
        tableView.reloadData()
    }
    
    // MARK:- Actions
    
    @objc private func addAction() {
        navigationController?.pushViewController(CreateWorkoutVC(mode: .create), animated: true)
    }

}

extension WorkoutListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workout = workoutList.list[indexPath.row]
        
        let workoutDetailVC = ExerciseListVC(workout: workout)
       navigationController?.pushViewController(workoutDetailVC, animated: true)
        
    }
    
    
    // Swipe cell
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
       let workout = workoutList.list[indexPath.row]
        
       // Edit SWIPE
        let editAction = UIContextualAction(style: .normal, title: "Edit") { action, view, completion in
            self.navigationController?.pushViewController(CreateWorkoutVC(mode: .edit(workout)), animated: true)
            completion(true)
        }
        
        editAction.backgroundColor = .dimmedBlue
        
        // DELETE SWIPE
        let deleteAction = UIContextualAction(style: .normal, title: "❌") { action, view, completion in
          
            // delete from the database
                guard let dispatcher = self.workoutDispatcher else {
                    print("\(self): dispatcher was nil ")
                    return
            }
            do {
                let request =  DeleteWorkoutRequest(id: try workout.requireID())
              let _ = try dispatcher.delete(request: request)
            }catch {
                completion(false)
                print("Show Error Modal with message: \(error)")
                return
            }
            
            // delete from the datasource
            guard let index = self.workoutList.list.firstIndex(where: { model in model.id == workout.id }) else {
                
                print("Show Error Modal: could find index")
                self.setupData()
                return
            }
            
           self.workoutList.list.remove(at: index)
            
            // delete from tableView
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
            tableView.reloadData()
        }
        deleteAction.backgroundColor = .dimmedBlue
        
        return UISwipeActionsConfiguration(actions: [deleteAction,editAction])
    }
    
}

extension WorkoutListVC:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.workoutList.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        
        guard let workoutCell = cell as? WorkoutCell else {
            return cell
        }
        
        let response = workoutList.list[indexPath.row]
        let model = WorkoutModel(title: response.title)
        workoutCell.set(model: model)
        return workoutCell
    }
}




















































