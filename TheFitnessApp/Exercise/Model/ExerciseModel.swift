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
    let kind: Kind
    
    init(id: Int64? = nil, workoutId: Int64, title: String, min: Int, sec: Int, kind: Kind) {
        self.id = id
        self.workoutId = workoutId
        self.title = title
        self.min = min
        self.sec = sec
        self.kind = kind
    }
    func requireID() throws -> Int64 {
        guard let id = id else {
            throw ExerciseError.idWasNil
        }
        return id
    }
    enum ExerciseError: Error {
        case idWasNil
        case unsuportedKind
    }
    
    enum Kind: String {
        case exercise
        case pause
    }
}
