//
//  CreateEcerxiseRequest.swift
//  TheFitnessApp
//
//  Created by MacBook on 02/10/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

struct CreateExerciseRequest {
    let workoutId: Int64
    var title: String
    var min: Int
    var sec: Int
    var kind: ExerciseModel.Kind
    
    func isValid() -> ValidationError  {
        if title.isEmpty {
            return  .titleIsEmpty
        }
        
        if min == 0 && sec == 0 {
            return .timeCannotBeZero
        }
        return .success
    }
    
    enum ValidationError: Error {
        case titleIsEmpty
        case timeCannotBeZero
        case success
    }
}
