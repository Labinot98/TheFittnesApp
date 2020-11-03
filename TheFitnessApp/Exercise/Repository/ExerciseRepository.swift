//
//  ExerciseRepository.swift
//  TheFitnessApp
//
//  Created by MacBook on 30/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import SQLite

final class ExerciseRepository {
    private let db: Connection
    static let table = Table(ExerciseModel.tableName)
    
    // Columns
    static let id = Expression<Int64>("id")
    static let workoutId = Expression<Int64>("workout_id")
    static let title = Expression<String>("title")
    static let min = Expression<Int>("min")
    static let sec = Expression<Int>("sec")
    
    static func dropTable(in db: Connection)throws{
        try db.execute("DROP TABLE  IF EXISTS '\(ExerciseModel.tableName)'")
        print("Dropped Table: \(WorkoutRepository.self)")
    }
    
    init(db: Connection) throws {
        self.db = db
        try setup()
    }
    
    //MARK - PRIVATE
    private func setup() throws {
        try db.run(ExerciseRepository.table.create(ifNotExists: true) { table in
            table.column(ExerciseRepository.id, primaryKey: true)
            table.column(
                ExerciseRepository.workoutId,
                references: WorkoutRepository.table,
                WorkoutRepository.id
            )
            table.column(ExerciseRepository.title)
            table.column(ExerciseRepository.min)
            table.column(ExerciseRepository.sec)
        })
        print( "Created Table (If it didnt exists): \(ExerciseModel.tableName)" )
    }
    
    
    // MARK: Public
    
    // INSERT
    func insert(request: CreateExerciseRequest) throws -> ExerciseModel {
        let insert = ExerciseRepository.table.insert(
            ExerciseRepository.workoutId <- request.workoutId,
            ExerciseRepository.title <- request.title,
            ExerciseRepository.min <- request.min,
            ExerciseRepository.sec <- request.sec
        )
        
        let rowId = try db.run(insert)
        
        return ExerciseModel(
            id: rowId,
            workoutId: request.workoutId,
            title: request.title,
            min: request.min,
            sec: request.sec
        )
    }
    
    // LIST
    func list(request: ListExerciseRequest) -> [ExerciseModel] {
        let query = ExerciseRepository.table.filter(ExerciseRepository.workoutId == request.workoutId)
        do {
            return try db.prepare(query).map { exercise in
                return ExerciseModel(
                    id: exercise[ExerciseRepository.id],
                    workoutId: exercise[ExerciseRepository.workoutId],
                    title: exercise[ExerciseRepository.title],
                    min: exercise[ExerciseRepository.min],
                    sec: exercise[ExerciseRepository.sec]
                )
            
            }
            
        } catch {
            print("\(self)Could't get list of \(ExerciseRepository.self) from the database ")
            return []
        }
    }
    
    // DELETE
    func delete(request: DeleteExerciseRequest) throws {
        let exercise = ExerciseRepository.table.filter(ExerciseRepository.id == request.exerciseId)
        try db.run(exercise.delete())
        
    }
    
}

extension ExerciseRepository {
    enum ExerciseRepostiryError: Error {
         case couldNotGetExerciseRepositoryInstance
    }
}






























