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
    private let table: Table
    
    //Columns
    private let id = Expression<Int64>("id")
    private let title = Expression<String>("title")
    
    static func dropTable(in db: Connection)throws{
        try db.execute("DROP TABLE  IF EXISTS '\(WorkoutModel.tableName)'")
        print("Dropped Table: \(WorkoutRepository.self)")
    }
    
    init(db: Connection) throws {
        self.db = db
        self.table = Table(WorkoutModel.tableName)
       try setup()
    }
    
    
    //MARK - PRIVATE
    private func setup() throws {
        try db.run(table.create(ifNotExists: true) { table in
            table.column(id, primaryKey: true)
            table.column(title)
        })
        print( "Created Table (If it didnt exists): \(WorkoutModel.tableName)" )
    }
    
    //MARK: - Public
    
    // CREATE
    func insert(model: WorkoutModel)throws -> WorkoutModel {
        let insert = table.insert(title <- model.title)
        let rowId = try db.run(insert)
        
        return WorkoutModel(id: rowId, title: model.title)
    }
    
    
    // GET
    func list() -> [WorkoutModel] {
        
        do {
            return try db.prepare(table).map { workout in
                return WorkoutModel(id: workout[id], title: workout[title])
            }
        } catch {
            print("\(self)Could't get list of workout from the database ")
            return []
        }
    }
    
    // UPDATE
    func update(request: UpdateWorkoutRequest) throws -> WorkoutModel {
        let workout = table.filter(id == request.id)
        
        try db.run(workout.update(title <- request.newTitle))
        return WorkoutModel(id: request.id, title: request.newTitle)
    }
    
}
















































