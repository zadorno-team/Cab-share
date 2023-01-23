//
//  WeatherManager.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 19/01/23.
//

import Foundation
import CoreLocation

class WeatherManager {
    let baseURL = "http://api.openweathermap.org/data/2.5/weather"
    let appid = "760cb0970ae941895591c62f42d4e50e"
    // MARK: - Request weather to Open Weather
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: "\(latitude)"),
            URLQueryItem(name: "lon", value: "\(longitude)"),
            URLQueryItem(name: "appid", value: appid)
        ]

        let url = urlComponents.url!

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
        return decodedData
    }
}

//guard let url: URLComponents = {
//    URLComponents(string:"http://api.openweathermap.org!)
//    url.path = "/data/2.5/weather"
//                  url.queryItems = [
//                    URLQueryItems(name: "lat", value: latitude)
//                    URLQueryItems(name: "lon", value: longtitude)
//                  ]
//
//                  lat=\(latitude)&lon=\(longitude)&appid=760cb0970ae941895591c62f42d4e50e")
//                  else {
//    fatalError("Missing URL")
//}
//}
