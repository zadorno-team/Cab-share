//
//  MapView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 24/01/23.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var latitude: CLLocationDegrees?
    @Binding var longitude: CLLocationDegrees?
    @State var annotation: MKPointAnnotation?
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        if let annotation = annotation {
            mapView.addAnnotation(annotation)
        }
        return mapView
    }
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude ?? 51.507359, longitude: longitude ?? -0.136439)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        self.annotation = annotation
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        uiView.setRegion(region, animated: true)
        uiView.addAnnotation(annotation)
    }
}
