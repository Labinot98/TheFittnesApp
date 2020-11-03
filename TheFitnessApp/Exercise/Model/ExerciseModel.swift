//
//  ExerciseModel.swift
//  TheFitnessApp
//
//  Created by MacBook on 30/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

final class ExerciseModel {
    static let tableName = "exercise"
    let id: Int64?
    let workoutId: Int64
    let title: String
    let min: Int
    let sec: Int
    
    init(id: Int64? = nil, workoutId: Int64, title: String, min: Int, sec: Int) {
        self.id = id
        self.workoutId = workoutId
        self.title = title
        self.min = min
        self.sec = sec
    }
    func requireID() throws -> Int64 {
        guard let id = id else {
            throw ExerciseError.idWasNil
        }
        return id
    }
    enum ExerciseError: Error {
        case idWasNil
    }
}
