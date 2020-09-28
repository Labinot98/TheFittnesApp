//
//  AppDelegate.swift
//  TheFitnessApp
//
//  Created by MacBook on 07/09/2020.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: WorkoutVC())
        window?.makeKeyAndVisible()
        
        // DEBUG
     //   MockDataManager.createWorkouts()
        // DEBUG
        
        return true
    }



}

