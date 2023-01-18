//
//  RideModel.swift
//  Cab share
//
//  Created by Viacheslav on 18/01/23.
//

import Foundation

struct FlightStatus: Codable {
    let flightNumber: String
    let iataCarrierCode: String
    let iataFlightNumber: String
    let departureDate: String

    let iataDepartureAirport: String
    let iataArrivalAirport: String
    let departureTime: String
    let arrivalDate: String
    let arrivalTime: String
}
