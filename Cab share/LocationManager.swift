//
//  LocationAPI.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 18/01/23.
//

import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var city: String = ""
    var onUpdate: ((String) -> Void)?

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
        geocoder.reverseGeocodeLocation(currentLocation) { (placemarks, error) in
            guard let placemark = placemarks?.first else { return }
            if placemark.locality != nil {
                self.city = "in " + placemark.locality!
            } else {
                self.city = ""
            }
            self.onUpdate?(self.city)
        }
    }
}