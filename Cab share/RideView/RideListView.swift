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
    @ObservedObject var rideVM: RideViewModel
    let flightNumber: String
    let flightDate: Date
    let rides = [
    AnotherRide(time: "10:00", freeSeats: 4),
    AnotherRide(time: "10:20", freeSeats: 1)
    ]

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 3) {
                        Text(rideVM.flightStatus?.data[0].departure.airport.iata ?? "")
                            .foregroundColor(.primary)
                            .font(.headline)
                        Text(rideVM.flightStatus?.data[0].departure.date ?? "")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                        Text(rideVM.flightStatus?.data[0].departure.passengerLocalTime ?? "")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 3) {
                        Text(rideVM.flightStatus?.data[0].arrival.airport.iata ?? "")
                            .foregroundColor(.primary)
                            .font(.headline)
                        Text(rideVM.flightStatus?.data[0].arrival.date ?? "")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                        Text(rideVM.flightStatus?.data[0].arrival.passengerLocalTime ?? "")
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                    }
                    Spacer()
                    Image(systemName: "arrowtriangle.right")
                }.padding(.vertical)
                    .padding(.horizontal, 50)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(.white, lineWidth: 1)
                            .padding(.horizontal, 25)
                    )
                List(rides) { ride in
                    RideRow(ride: ride)
                }
            }
        }.task {
            await rideVM.getFlightStatus(userFlightNumber: flightNumber, userDepartureDate: flightDate)
        }
    }
}

struct RideListView_Previews: PreviewProvider {
    static var previews: some View {
        RideListView(rideVM: RideViewModel(), flightNumber: "", flightDate: Date.now)
    }
}
