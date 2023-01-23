//
//  BudgetZApp.swift
//  BudgetZ
//
//  Created by Arunkumar Chandrasekar on 16/01/23.
//

import SwiftUI

@main
struct BudgetZApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            OnBoardingScreen()
        }
    }
}
