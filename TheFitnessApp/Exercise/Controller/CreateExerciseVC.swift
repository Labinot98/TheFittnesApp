//
//  CreateExerciseVC.swift
//  TheFitnessApp
//
//  Created by MacBook on 21/10/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

final class CreateExerciseVC: UIViewController {
    
    
    private var createExerciseRequest: CreateExerciseRequest?
    private var updateExerciseRequest: UpdateExerciseRequest?
    
    private var safeArea: UILayoutGuide!
    private let nameTextField = NeuTextField(title: "Name")
    private let timeTextField = NeuTimeTextField()
    private let exercisePauseLabel = UILabel()
    private let exercisePauseControl = UISegmentedControl(items: ["Exercise", "Pause"])
    private let saveCancelButton = SaveCancelButtons()
    
    private let exerciseDispatcher = try? ExerciseDispatcher()
    private var mode: Mode
    private var exerciseModel: ExerciseModel?
    
    enum Mode {
        case create(Int64)
        case edit (ExerciseModel)
    }
    
    init(mode: Mode) {
        self.mode = mode
         super.init(nibName: nil, bundle: nil)
        switch mode {
        case .create(let workoutId):
            self.createExerciseRequest = CreateExerciseRequest(
                workoutId: workoutId,
                title: "",
                min: 0,
                sec: 0,
                kind: .exercise
            )
        case .edit(let exerciseModel):
            self.setupData(with: exerciseModel)
        }
        
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
          setupExercisePauseLabel()
        setupExercisePauseControl()
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
        
        nameTextField.delegate = self
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
    
    private func setupExercisePauseLabel() {
        view.addSubview(exercisePauseLabel)
        
        exercisePauseLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = exercisePauseLabel.topAnchor.constraint(equalTo: timeTextField.bottomAnchor, constant: 30)
         let leading = exercisePauseLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        
         NSLayoutConstraint.activate([top, leading])
        
        exercisePauseLabel.text = "Type"
        exercisePauseLabel.textColor = .customWhite
        exercisePauseLabel.font = .boldSystemFont(ofSize: 24)
    }
    
    private func setupExercisePauseControl() {
        view.addSubview(exercisePauseControl)
        
        exercisePauseControl.translatesAutoresizingMaskIntoConstraints = false
        let top = exercisePauseControl.topAnchor.constraint(equalTo: exercisePauseLabel.bottomAnchor, constant: 15)
        let leading = exercisePauseControl.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor)
        let trailing = exercisePauseControl.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        NSLayoutConstraint.activate([top, leading, trailing])
        
        exercisePauseControl.tintColor = .customWhite
        exercisePauseControl.addTarget(self, action: #selector(exercisePauseAction), for: .valueChanged)
    
        switch mode {
        case .create(_): exercisePauseControl.selectedSegmentIndex = SegmentedControlItem.exercise.rawValue
        default: return
        }
    }
    
    // MARK: - Action
    
    @objc private func exercisePauseAction(_ control: UISegmentedControl) {
        
        if let title = control.titleForSegment(at: control.selectedSegmentIndex),
            let controlItem = ExerciseModel.Kind(rawValue: title.lowercased())
        {
            switch mode {
            case .create(_): createExerciseRequest?.kind = controlItem
            case .edit(_): updateExerciseRequest?.kind = controlItem
            }
        }
    }
    
    // MARK: - Logic
    
    private func setupData(with model: ExerciseModel) {
        nameTextField.set(name: model.title)
        let timeModel = NeuTimeTextField.Model(min: model.min, sec: model.sec)
        timeTextField.set(with: timeModel)
        
        guard let segmentetIndex = SegmentedControlItem(kind: model.kind)?.rawValue else {
            print("❌ Could not populate Exercise/Pause Segmenterd control based on \(model.kind)")
            return
        }
        exercisePauseControl.selectedSegmentIndex = segmentetIndex
        
        guard let exerciseId = model.id else {
            print("❌ Exercise Id qas nil in model: ", model)
            return
        }
        
        self.updateExerciseRequest = UpdateExerciseRequest(
            id: exerciseId,
            title: model.title,
            min: model.min,
            sec: model.sec,
            kind: model.kind
        )
    }
    
    private func createExercise() {
        

        
        // VALIDATION createExreciseRequest before persisting
        
        
        guard let dispatcher = exerciseDispatcher else {
            print("\(self): workoutDispatcher was nil")
            return
        }
        guard let request = createExerciseRequest else  {
            print("\(self): createExerciseRequest was nil")
            return
        }
        
        guard ((try? dispatcher.create(request: request)) != nil) else {
            print("Show Modal saying: 'Could't save workout, please reach oit to Developer ")
            return
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    private func updateExercise() {
        guard let dispatcher = exerciseDispatcher else {
            print("\(self): workoutDispatcher was nil")
            return
        }
        guard let request = updateExerciseRequest else  {
            print("\(self): updateExerciseRequest was nil")
            return
        }
        
        guard ((try? dispatcher.update(request: request)) != nil) else {
            print("Show Modal saying: 'Could't save workout, please reach oit to Developer ")
            return
        }
        
        navigationController?.popViewController(animated: true)
        print("call update funccc")
    }
    
}

// E kena bo ni protocol se mena delegu te dhenat nga NeuTimeTF
extension CreateExerciseVC: NeuTimeTextFieldDelegate {
    func valuesDidChange(to min: Int, sec: Int) {
        switch mode {
        case .create(_):
            createExerciseRequest?.min = min
            createExerciseRequest?.sec = sec
        case .edit(_):
            updateExerciseRequest?.min = min
            updateExerciseRequest?.sec = sec
        }
    }
}

extension CreateExerciseVC: SaveCancelButtonDelegate {
    func onCancel() {
        navigationController?.popViewController(animated: true)
    }
    
    func onSave() {
        
        switch mode {
        case .create(_): createExercise()
        case .edit(_): updateExercise()
        }
    }
}

extension CreateExerciseVC {
    enum SegmentedControlItem: Int {
        case exercise
        case pause
        
        var description: String {
            switch self {
            case .exercise: return "exercise"
            case .pause: return "pause"
            }
        }
        
        init?(kind: ExerciseModel.Kind) {
            switch kind {
            case .exercise: self.init(rawValue: 0)
            case .pause: self.init(rawValue: 1)
            }
        }
    }
}

extension CreateExerciseVC: NeuTextFieldDelegate {
    func valuesDidChange(to text: String) {
        switch mode {
        case .create(_): createExerciseRequest?.title = text
        case .edit(_): updateExerciseRequest?.title = text
        }
    }
}












































