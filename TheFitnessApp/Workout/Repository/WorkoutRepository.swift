//
//  WorkoutRepository.swift
//  TheFitnessApp
//
//  Created by MacBook on 10/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import  SQLite

final class WorkoutRepository {
    // Table Name
//    private static let tableName = "workout"
    
    //Table
    private let db: Connection
    static let table = Table(WorkoutModel.tableName)
    
    //Columns
    static let id = Expression<Int64>("id")
    static let title = Expression<String>("title")
    
    static func dropTable(in db: Connection)throws{
        try db.execute("DROP TABLE  IF EXISTS '\(WorkoutModel.tableName)'")
        print("Dropped Table: \(WorkoutRepository.self)")
    }
    
    init(db: Connection) throws {
        self.db = db
       try setup()
    }
    
    
    //MARK - PRIVATE
    private func setup() throws {
    try db.run(WorkoutRepository.table.create(ifNotExists: true) {
            table in
        table.column(WorkoutRepository.id, primaryKey: true)
        table.column(WorkoutRepository.title)
        })
        print( "Created Table (If it didnt exists): \(WorkoutModel.tableName)" )
    }
    
    //MARK: - Public
    
    // CREATE
    func insert(request: CreateWorkoutRequest)throws -> WorkoutModel {
        let insert = WorkoutRepository.table.insert(WorkoutRepository.title <- request.title)
        let rowId = try db.run(insert)
        
        return WorkoutModel(id: rowId, title: request.title)
    }
    
    
    // GET
    func list() -> [WorkoutModel] {
        
        do {
            return try db.prepare(WorkoutRepository.table).map { workout in
                return WorkoutModel(id: workout[WorkoutRepository.id], title: workout[WorkoutRepository.title])
            }
        } catch {
            print("\(self)Could't get list of workout from the database ")
            return []
        }
    }
    
    // UPDATE
    func update(request: UpdateWorkoutRequest) throws -> WorkoutModel {
        let workout = WorkoutRepository.table.filter(WorkoutRepository.id == request.id)
        try db.run(workout.update(WorkoutRepository.title <- request.newTitle))
        return WorkoutModel(id: request.id, title: request.newTitle)
    }
    
    // DELETE
    func delete(request: DeleteWorkoutRequest) throws {
        let workout = WorkoutRepository.table.filter(WorkoutRepository.id == request.id)
       try db.run(workout.delete())
        
    }
    
}
















































