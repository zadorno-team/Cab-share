//
//  DataController.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 12/01/23.
//

import CoreData
import Foundation

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "UserData")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
