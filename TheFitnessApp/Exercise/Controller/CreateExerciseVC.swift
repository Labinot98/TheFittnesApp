//
//  CreateExerciseVC.swift
//  TheFitnessApp
//
//  Created by MacBook on 21/10/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class CreateExerciseVC: UIViewController {
    
    var workoutId: Int64
    
    private var createExerciseRequest: CreateExerciseRequest
    
    private var safeArea: UILayoutGuide!
    private let nameTextField = NeuTextField(title: "Name")
    private let timeTextField = NeuTimeTextField()
    private let saveCancelButton = SaveCancelButtons()
    
    private let exerciseDispatcher = try? ExerciseDispatcher()
    
    init(workoutId: Int64) {
        self.workoutId = workoutId
        self.createExerciseRequest = CreateExerciseRequest(workoutId: workoutId, title: "", min: 0, sec: 0)
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
        setupNameTextField()
        setupTimeTextField()
        setupSaveCancelButtons()
    }
    
    private func setupNavigation(){
        navigationItem.title = "Create"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.customWhite]
    }
    
    private func setupNameTextField() {
        
        view.addSubview(nameTextField)
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        let top = nameTextField.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 30)
        let leading = nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        let trailing = nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        NSLayoutConstraint.activate([top, leading, trailing])
        
    }
    private func setupTimeTextField() {
        
        view.addSubview(timeTextField)
        
        timeTextField.translatesAutoresizingMaskIntoConstraints = false
        let top = timeTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30)
        let leading = timeTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        let trailing = timeTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        NSLayoutConstraint.activate([top, leading, trailing])
        
        timeTextField.delegate = self  
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
    
    private func createExercise() {
        
        guard let title = nameTextField.text, !title.isEmpty else {
            print("Title cannot be empty {Model}")
            return
        }
        createExerciseRequest.title = title
        
        // VALIDATION createExreciseRequest before persisting
        guard let dispatcher = exerciseDispatcher else {
            print("\(self): workoutDispatcher was nil")
            return
        }
        
        guard ((try? dispatcher.create(request: createExerciseRequest)) != nil) else {
            print("Show Modal saying: 'Could't save workout, please reach oit to Developer ")
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
}

// E kena bo ni protocol se mena delegu te dhenat nga NeuTimeTF
extension CreateExerciseVC: NeuTimeTextFieldDelegate {
    func valuesDidChange(to min: Int, sec: Int) {
        createExerciseRequest.min = min
        createExerciseRequest.sec = sec
    }
}

extension CreateExerciseVC: SaveCancelButtonDelegate {
    func onCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func onSave() {
        createExercise()
    }
}















































