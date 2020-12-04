//
//  MockDataManager.swift
//  TheFitnessApp
//
//  Created by MacBook on 18/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

struct MockDataManager {
    
   static func createWorkouts(amount: Int = 7) {
    guard let dbManager = DatabaseManager.default else {
    return
    }
    
    // Mi merr te gjitha ato krijime qi ikemi bo te workout table
        for number in 1...amount {
            let request = CreateWorkoutRequest(title: "\(number) - Labinot Pajaziti")
            guard (try? dbManager.workoutRepository.insert(request: request)) != nil else {
                print("Couldn't insert into workout table")
                return
            }
        }
    }
}










































