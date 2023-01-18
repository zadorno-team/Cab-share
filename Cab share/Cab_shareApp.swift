//
//  Cab_shareApp.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI
import CoreData
import FirebaseCore

@main
struct CabShareApp: App {
    @StateObject var dataController = DataController()
    @StateObject var loginViewModel = LoginViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            RoutingView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(loginViewModel)
        }
    }
}
