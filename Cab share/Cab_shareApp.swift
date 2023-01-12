//
//  Cab_shareApp.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI
import CoreData

@main
struct Cab_shareApp: App {
    
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .preferredColorScheme(.dark)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
