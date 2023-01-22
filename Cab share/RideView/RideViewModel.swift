//
//  RideViewModel.swift
//  Cab share
//
//  Created by Viacheslav on 18/01/23.
//

import Foundation
import SwiftUI

@MainActor
class RideViewModel: ObservableObject {
    @Published var flightStatus: FlightData?
    @Published var userFlightNumber: String?
    @Published var userDepartureDate: Date?
    let decoder = JSONDecoder()
    var urlComponents: URLComponents = {
        var baseUrl = URLComponents(string: "https://flight-info-api.p.rapidapi.com")!
        baseUrl.path = "/status"
        baseUrl.queryItems = [
            URLQueryItem(name: "version", value: "v1"),
            URLQueryItem(name: "DepartureDate", value: "2023-01-19"),
            URLQueryItem(name: "IataCarrierCode", value: "W6"),
            URLQueryItem(name: "FlightNumber", value: "4370")]
#warning("we should fill DepartureDate with departureDate YYYY-MM-DD")
#warning("we should fill IataCarrierCode with iataCarrierCode 2 digits/letters")
#warning("we should fill FlightNumber with iataFlightNumber 4 digits")
        print(baseUrl)
        return baseUrl
    }()
    func getFlightStatus() async {
        let headers = [
            "X-RapidAPI-Key": "fdd94b659fmsha76c97a227504fap10bbb6jsn78d9220a014a",
            "X-RapidAPI-Host": "flight-info-api.p.rapidapi.com"
        ]
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            self.flightStatus = try decoder.decode(FlightData.self, from: data)
        } catch {
            print(error)
        }
    }
}

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int
    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}
