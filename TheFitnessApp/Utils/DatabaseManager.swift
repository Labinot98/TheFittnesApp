//
//  DatabaseManager.swift
//  TheFitnessApp
//
//  Created by MacBook on 10/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//
import Foundation
import SQLite


final class DatabaseManager {
    
    let db: Connection
    static let `default` = try? DatabaseManager()
    
    let workoutRepository: WorkoutRepository
    let exerciseRepository: ExerciseRepository
    
    init() throws {
        guard
            let path = FileManager
                .default
                .urls(for: .documentDirectory, in: .userDomainMask)
                .first
            else {
                throw DatabaseError.couldNotFindPathToCreateADatabaseFileIn
                
        }
    
        db = try Connection(("\(path)db.sqlite3"))
        print(db.description)
        //Dropping all tables
       try WorkoutRepository.dropTable(in: db)
        try ExerciseRepository.dropTable(in: db)
        
        // Createing all tables
        workoutRepository = try WorkoutRepository(db: db)
        exerciseRepository = try ExerciseRepository(db: db)
    }
    
    
}

extension DatabaseManager {
    enum DatabaseError: Error {
        case couldNotFindPathToCreateADatabaseFileIn
         case couldNotGetDatabaseManagerInstance
    }
}




















































