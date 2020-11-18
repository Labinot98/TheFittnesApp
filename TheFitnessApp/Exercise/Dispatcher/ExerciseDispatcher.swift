//
//  ExerciseDispatcher.swift
//  TheFitnessApp
//
//  Created by MacBook on 02/10/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

struct ExerciseDispatcher {
    private let exerciseRepository: ExerciseRepository
    
    init() throws {
        guard let databaseMangaer = DatabaseManager.default else {
            throw DatabaseManager.DatabaseError.couldNotGetDatabaseManagerInstance
        }
        
        guard let exerciseRepository = try? ExerciseRepository(db: databaseMangaer.db) else {
            throw ExerciseRepository.ExerciseRepostiryError.couldNotGetExerciseRepositoryInstance
        }
        self.exerciseRepository = exerciseRepository
    }
    
    // Create A Exercise .   CREATE
    func create(request: CreateExerciseRequest) throws -> CreateExerciseResponse {
        let persistedModel = try exerciseRepository.insert(request: request)
        return CreateExerciseResponse(exercise: persistedModel)
    }
    
    // Return list of all Exercise   GET
    func list(request: ListExerciseRequest)  -> ListExerciseResponse {
        let list =  exerciseRepository.list(request: request)
        return ListExerciseResponse(list: list)
    }
    
    
    // Delete an exercise.
    func delete(request: DeleteExerciseRequest) throws -> DeleteExerciseResponse {
        try exerciseRepository.delete(request: request)
        return DeleteExerciseResponse()
    }
    
    // Update an exercise
    func update(request: UpdateExerciseRequest) throws -> UpdateExercsieResponse{
        try exerciseRepository.update(request: request)
    return UpdateExercsieResponse()
    }
}

