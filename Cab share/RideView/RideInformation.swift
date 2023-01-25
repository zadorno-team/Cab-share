//
//  RideInformation.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 25/01/23.
//

import Foundation

class RideInformation: ObservableObject {
    @Published var searchBar = false
    @Published var searchText: String = ""
    @Published var flightNumber = ""
}
