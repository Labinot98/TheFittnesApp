//
//  CreateWorkoutVC.swift
//  TheFitnessApp
//
//  Created by MacBook on 24/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class CreateWorkoutVC: UIViewController {
    private var safeArea: UILayoutGuide!
    private let titleLabel = UILabel()
    private let nameTF = TextField(padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
    private let saveCancelButton = SaveCancelButtons()
    private let workoutDispatcher = try? WorkoutDispatcher()
    
    private var mode: Mode
    private var workoutModel: WorkoutModel?
    
    enum Mode {
        case create
        case edit(WorkoutModel)
    }

    
    init(mode: Mode) {
         self.mode = mode
        switch mode {
        case .create: ()
        case .edit(let workoutModel):
            self.workoutModel = workoutModel
            nameTF.text = workoutModel.title
        }
          super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        safeArea = view.layoutMarginsGuide
        view.backgroundColor = .dimmedBlue
        setupNavigation()
        setupTitleLabel()
        setupNameTextField()
        setupSaveCancelButtons()
    }
    
    private func setupNavigation(){
        switch mode {
        case .create: navigationItem.title = "Create"
        case .edit(_): navigationItem.title = "Edit"
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customWhite]
    }
    
    private func setupTitleLabel(){
        view.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        let trailing = titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        NSLayoutConstraint.activate([top, leading, trailing])
        
        titleLabel.text = "Name"
        titleLabel.textColor = .customWhite
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
    }
    
    private func setupNameTextField() {
        
        view.addSubview(nameTF)
        
        nameTF.translatesAutoresizingMaskIntoConstraints = false
        let top = nameTF.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        let leading = nameTF.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        let trailing = nameTF.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        let height = nameTF.heightAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([top, leading, trailing, height])
        
//        nameTF.backgroundColor = .customWhite
        nameTF.layer.cornerRadius = 10
        nameTF.font = .systemFont(ofSize: 26)
        nameTF.textColor = .customWhite
//        nameTF.placeholder = "Type Exercise"
//        nameTF.attributedPlaceholder = NSAttributedString(string: "Type Exercise", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        nameTF.returnKeyType = .done
        nameTF.delegate = self
        
    }
    
    private func setupSaveCancelButtons() {
        view.addSubview(saveCancelButton)
        
        saveCancelButton.translatesAutoresizingMaskIntoConstraints = false
        let leading = saveCancelButton.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        let bottom = saveCancelButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor,constant: -20)
        let trailing = saveCancelButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        
        NSLayoutConstraint.activate([bottom, leading, trailing])
        
        saveCancelButton.delegate = self
    }
    
    // MARK: - Logic
    
    private func createWorkout(title: String) {
        let request = CreateWorkoutRequest(title: title)
        guard let dispatcher = workoutDispatcher else {
            print("\(self): workoutDispatcher was nil")
            return
        }
        
        guard ((try? dispatcher.create(request: request)) != nil) else {
            print("Show Modal saying: 'Could't save workout, please reach oit to Developer ")
            return
        }
    }
    
    // Edit Workout
    private func updateWorkout(title: String) {
        guard
            let model = workoutModel,
            let id = model.id,
            let dispatcher = workoutDispatcher
            else {
            print("\(self): wokroutModel or workoutDispatcher is nil")
            return
        }
        let request = UpdateWorkoutRequest(id: id, newTitle: title)
        
        guard ((try? dispatcher.update(request: request)) != nil) else {
            print("Show Modal saying: 'Could't save workout, please reach oit to Developer ")
            return
        }
    }
}

extension CreateWorkoutVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
 }


extension CreateWorkoutVC: SaveCancelButtonDelegate {
    func onCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func onSave() {
        if let title = nameTF.text, !title.isEmpty {
            print(" ✅ Persisted to database")
            
            switch mode {
            case .create: createWorkout(title: title)
            case .edit(_): updateWorkout(title: title)
            }
            
            
            navigationController?.popViewController(animated: true)
        }
    }
}

















































