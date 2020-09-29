//
//  WorkoutModel.swift
//  TheFitnessApp
//
//  Created by MacBook on 09/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

struct WorkoutModel {
    static let tableName = "workout"
    let id: Int64?
    let title: String
    
    init(id: Int64? = nil, title: String) {
        self.id = id
        self.title = title
    }
    
    func requireID() throws -> Int64 {
        guard let id = id else {
            throw WorkoutError.idWasNil
        }
        return id
    }
    
    enum WorkoutError: Error {
        case idWasNil
    }
}
