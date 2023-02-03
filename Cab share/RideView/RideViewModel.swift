//
//  RideViewModel.swift
//  Cab share
//
//  Created by Viacheslav on 18/01/23.
//

import Foundation
import SwiftUI
import CoreLocation

@MainActor
class RideViewModel: ObservableObject {
    @Published var locationManager = LocationManager()
    @Published var flightStatus: FlightData?
    @Published var error: String?
    @Published var previousApiRequests: [[String: String]] = (
        UserDefaults.standard.array(forKey: "LastApi") as? [[String: String]]) ?? []
    private let wrongFlightNumberError = "Please enter valid flight number. Ex: F2 1122"
    func getFlightStatus(userFlightNumber: String, userDepartureDate: Date) async {
        let decoder = JSONDecoder()
        let airlineCode: String = String(userFlightNumber.prefix(2))
        let flightCode: String = String(userFlightNumber.suffix(4))
        let dateString = dateToString(date: userDepartureDate)
        let urlComponents: URLComponents = {
            var baseUrl = URLComponents(string: "https://flight-info-api.p.rapidapi.com")!
            baseUrl.path = "/status"
            baseUrl.queryItems = [
                URLQueryItem(name: "version", value: "v1"),
                URLQueryItem(name: "DepartureDate", value: dateString),
                URLQueryItem(name: "IataCarrierCode", value: airlineCode.uppercased()),
                URLQueryItem(name: "FlightNumber", value: flightCode)
            ]
            print(baseUrl)
            print(airlineCode)
            print(flightCode)
            print(dateString)
            return baseUrl
        }()
        let headers = [
            "X-RapidAPI-Key": "392c21c50cmsha3a896885e4cc53p1bc7dfjsn3252bf0acb97",
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
        saveApiRequest()
    }
    func dateToString(date: Date) -> String {
        let nameFormatter = DateFormatter()
        nameFormatter.dateFormat = "yyyy-MM-dd"
        let departureDate = nameFormatter.string(from: date)
        return departureDate
    }
    func checkFlightNumber(userInput value: String) {
        guard let regexExpression = try? NSRegularExpression(
            pattern: "(?<![\\dA-Z])(?!\\d{2})([A-Z\\d]{2})\\s?(\\d{2,4})(?!\\d)"
        )
        else {
            return
        }
        let valueUpper = value.uppercased()
        let range = NSRange(location: 0, length: valueUpper.utf16.count)
        let result = regexExpression.firstMatch(in: valueUpper, options: [], range: range)
        if result != nil {
            error = nil
        } else {
            if valueUpper.count > 5 {
                error = wrongFlightNumberError
            } else {
                error = nil
            }
        }
    }
    func saveApiRequest() {
        previousApiRequests.append([
            "departureAirport": flightStatus!.data[0].departure.airport.iata,
            "departureDate": flightStatus!.data[0].departure.date,
            "departureTime": flightStatus!.data[0].departure.passengerLocalTime,
            "arrivalAirport": flightStatus!.data[0].arrival.airport.iata,
            "arrivalDate": flightStatus!.data[0].arrival.date,
            "arrivalTime": flightStatus!.data[0].arrival.passengerLocalTime,
            "dateOfRequest": dateToString(date: Date.now)
            ])
            UserDefaults.standard.set(previousApiRequests, forKey: "LastApi")
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

class RideInformation: ObservableObject {
    @Published var searchBar = false
    @Published var searchText: String = ""
    @Published var flightNumber = ""
    @Published var latitude: CLLocationDegrees?
    @Published var longitude: CLLocationDegrees?
}

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var city: String = ""
    @Published var location: CLLocationCoordinate2D?
    @Published var status: String?

    override init() {
        super.init()
        locationManager.delegate = self
        startUpdatingLocation()
    }

    func startUpdatingLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, _) in
            guard let placemark = placemarks?.first else { return }
            if placemark.locality != nil {
                self.location = locations.last?.coordinate
                self.city = "in " + placemark.locality!
            } else {
                self.city = ""
            }
        }
    }
}
