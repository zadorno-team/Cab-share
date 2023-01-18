//
//  RideViewModel.swift
//  Cab share
//
//  Created by Viacheslav on 18/01/23.
//

import Foundation

@MainActor
class RideViewModel: ObservableObject {
    
    @Published var flightStatus: FlightStatus?
    
    let decoder = JSONDecoder()
    
    var urlComponents: URLComponents = {
        var baseUrl = URLComponents(string: "https://flight-info-api.p.rapidapi.com")!
        baseUrl.path = "/status"
        baseUrl.queryItems = [
        URLQueryItem(name: "version", value: "v1"),
        URLQueryItem(name: "DepartureDate", value: departureDate),
        URLQueryItem(name: "IataCarrierCode", value: iataCarrierCode),
        URLQueryItem(name: "FlightNumber", value: iataFlightNumber)]
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
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription ?? "some error")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse ?? "default value")
            }
        })
        
        dataTask.resume()
    }
}
