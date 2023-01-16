//
//  HistoryView.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI
import CoreData

struct RideHistory: Identifiable {
    let id = UUID()
    let date: String
    let goFrom: String
    let goTo: String
}

struct HistoryView: View {

    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Ride.date, ascending: false)]
    ) var rides: FetchedResults<Ride>

    var previousRides = [
        RideHistory(date: "3 November, 2022", goFrom: "International Airport of Naples", goTo: "Portici"),
        RideHistory(date: "12 December, 2022", goFrom: "International Airport of Naples", goTo: "Portici")
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(previousRides) { ride in
                    HistoryRowView(ride: ride)
                }
            }
            .navigationTitle("Previous Rides")
            .preferredColorScheme(.dark)
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
