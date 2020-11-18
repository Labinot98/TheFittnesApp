//
//  ExerciseListVC.swift
//  TheFitnessApp
//
//  Created by MacBook on 29/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class ExerciseListVC: UIViewController {
    
    private let exerciseDispatcher = try? ExerciseDispatcher()
    private var safeArea: UILayoutGuide!
    private let tableView = UITableView()
    private var exerciseList = ListExerciseResponse(list: [])
    
    let workout: WorkoutModel
    
    init(workout: WorkoutModel) {
        self.workout = workout
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        tableView.separatorStyle = .none
    }
    
    // MARK: - Logic
    private func setupData() {
        guard let dispatcher = exerciseDispatcher else {
            print("\(self): dispatcehr was nil.")
            return
        }
        guard let workoutId = try? workout.requireID() else {
            print("\(self): workout id was nil.")
            return
        }
        
        let request = ListExerciseRequest(workoutId: workoutId)
        exerciseList = dispatcher.list(request: request)
        tableView.reloadData()
    }
    
    @objc func addAction() {
        guard let workoutId = try? workout.requireID() else {
            print("\(self): workout id was nil")
            return
        }
        
        let vc = CreateExerciseVC(mode: .create(workoutId))
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ExerciseListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.list.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        guard let exerciseCell = cell as? ExerciseCell else { return cell}
        
        let model = exerciseList.list[indexPath.row]
         print("Done", model.kind)
        exerciseCell.set(model: model)
        return cell
    }
}

extension ExerciseListVC: UITableViewDelegate {
   
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
          let exercise = exerciseList.list[indexPath.row]
        // DELETE SWIPE
        let deleteAction = UIContextualAction(style: .normal, title: "❌") { action, view, completion in
           
            // delete from the database
            guard let dispatcher = self.exerciseDispatcher else {
                print("\(self): dispatcher was nil ")
                return
            }
            do {
                let request =  DeleteExerciseRequest(exerciseId: try exercise.requireID())
                let _ = try dispatcher.delete(request: request)
            }catch {
                completion(false)
                print("Show Error Modal with message: \(error)")
                return
            }
            
            // delete from the datasource
            guard let index = self.exerciseList.list.firstIndex(where: { model in model.id == exercise.id }) else {
                
                print("Show Error Modal: could find index")
                self.setupData()
                return
            }
            
            self.exerciseList.list.remove(at: index)
            
            // delete from tableView
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
            tableView.reloadData()
            
        }
        deleteAction.backgroundColor = .dimmedBlue
        
        let editAciton = UIContextualAction(style: .normal, title: "Edit") { action, view, completion in
            let model = self.exerciseList.list[indexPath.row]
            let vc = CreateExerciseVC(mode: .edit(model))
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        editAciton.backgroundColor = .dimmedBlue
        return UISwipeActionsConfiguration(actions: [deleteAction, editAciton])
    }
    
}
















































