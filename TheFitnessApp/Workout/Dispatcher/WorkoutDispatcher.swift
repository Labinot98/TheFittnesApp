//
//  WorkoutDispatcher.swift
//  TheFitnessApp
//
//  Created by MacBook on 23/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

struct WorkoutDispatcher {
   private let workoutRepository: WorkoutRepository
    
    init() throws {
        guard let databaseMangaer = DatabaseManager.default else {
           throw WorkoutDispatcherError.couldNotGetDatabaseManagerInstance
        }
        
        guard let workoutRepository = try? WorkoutRepository(db: databaseMangaer.db) else {
            throw WorkoutDispatcherError.couldNotGetWorkoutRepositoryInstance
        }
         self.workoutRepository = workoutRepository
    }
    
    // Create A WORKOUT .   CREATE
    func create(request: CreateWorkoutRequest) throws -> CreateWorkoutResponse {
        let model = WorkoutModel(title: request.title)
       let persistedModel = try workoutRepository.insert(model: model)
        
        return CreateWorkoutResponse(workout: persistedModel)
    }
    
    // Return list of all workouts GET
    func list(request: ListWorkoutRequest)  -> ListWorkoutResponse {
        let list =  workoutRepository.list()
        return ListWorkoutResponse(list: list)
    }
    
    // UPDATE a workout based on it's id.
    func update(request: UpdateWorkoutRequest) throws -> UpdateWorkoutResponse {
      let persistedModel = try workoutRepository.update(request: request)
        return UpdateWorkoutResponse(title: persistedModel.title)
    }
}

extension WorkoutDispatcher {
    enum WorkoutDispatcherError: Error {
        case couldNotGetDatabaseManagerInstance
        case couldNotGetWorkoutRepositoryInstance
    }
}























































