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
    @StateObject var sessionService = SessionServiceImpl()
    @StateObject var rideInformation = RideInformation()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            NavigationView {
                switch sessionService.state {
                case .loggedIn:
                    MainView()
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                        .environmentObject(sessionService)
                        .environmentObject(rideInformation)
                case .loggedOut:
                    LoginView()
                }
            }
        }
    }
}
