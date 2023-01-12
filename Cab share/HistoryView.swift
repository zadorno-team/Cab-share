//
//  HistoryView.swift
//  Cab share
//
//  Created by Viacheslav on 11/01/23.
//

import SwiftUI

struct HistoryView: View {
    struct Ride: Identifiable {
        let id = UUID()
        let date: String
        let from: String
        let to: String
    }
    
    var previousRides = [
        Ride(date: "3 November, 2022", from: "International Airport of Naples", to: "Portici"),
        Ride(date: "12 December, 2022", from: "International Airport of Naples", to: "Portici")
    ]
    
    struct previousRidesRowView: View {
        var ride: Ride
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 3) {
                    Text(ride.date)
                        .foregroundColor(.primary)
                        .font(.headline)
                    VStack(alignment: .leading, spacing: 3) {
                        Text("from: \(ride.from)")
                        Text("to: \(ride.to)")
                    }
                    .foregroundColor(.secondary)
                    .font(.subheadline)
                }
                Spacer()
                Image(systemName: "arrowtriangle.right")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(previousRides) { ride in
                    previousRidesRowView(ride: ride)
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
