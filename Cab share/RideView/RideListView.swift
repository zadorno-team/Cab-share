//
//  RideListView.swift
//  Cab share
//
//  Created by Viacheslav on 25/01/23.
//

import SwiftUI

struct AnotherRide: Identifiable {
    let id = UUID()
    let time: String
    let freeSeats: Int
}

struct RideRow: View {
    var ride: AnotherRide

    var body: some View {
        Text(ride.time)
    }
}

struct RideListView: View {
    let rides = [
    AnotherRide(time: "10:00", freeSeats: 4),
    AnotherRide(time: "10:20", freeSeats: 1)
    ]

    var body: some View {
        List(rides) { ride in
            RideRow(ride: ride)
        }
    }
}

struct RideListView_Previews: PreviewProvider {
    static var previews: some View {
        RideListView()
    }
}
