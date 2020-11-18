//
//  UpdateExerciseRequest.swift
//  TheFitnessApp
//
//  Created by MacBook on 13/11/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

struct UpdateExerciseRequest {
    let id: Int64?
    var title: String
    var min: Int
    var sec: Int
    var kind: ExerciseModel.Kind
}
