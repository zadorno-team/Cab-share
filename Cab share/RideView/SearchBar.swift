//
//  SearchBar.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 12/01/23.
//

import SwiftUI
import MapKit

struct SearchBar: View {
    @EnvironmentObject var rideInformation: RideInformation
    @State private var filteredItems: [MKMapItem] = []
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color.white)
                CustomTextField(placeholder: Text("Where to?").foregroundColor(.white), text: $rideInformation.searchText)
                Button(action: {
                    self.rideInformation.searchText = ""
                }, label: {
                    if !rideInformation.searchText.isEmpty {
                        Image(systemName: "xmark.circle.fill").foregroundColor(.white)
                    }})
            }.padding(10)
                .padding(.top, 20)
                .onChange(of: rideInformation.searchText) { newValue in
                    let request = MKLocalSearch.Request()
                    request.naturalLanguageQuery = newValue
                    let search = MKLocalSearch(request: request)
                    search.start { response, _ in
                        guard let response = response else { return }
                        let mapItems = response.mapItems
                        filteredItems = mapItems.filter {
                            $0.placemark.name?.contains(self.rideInformation.searchText) ?? false }.map{$0}
                    }
                }
            Divider()
            ScrollView {
                ForEach(filteredItems) { item in
                    Button {
                        rideInformation.searchText = "\(item.placemark.thoroughfare ?? "") \(item.placemark.subThoroughfare ?? ""), \(item.placemark.locality ?? "") \(item.placemark.postalCode ?? "")"
                        rideInformation.latitude = item.placemark.coordinate.latitude
                        rideInformation.longitude = item.placemark.coordinate.longitude
                        rideInformation.searchBar.toggle()
                    } label: {
                        VStack(alignment: .leading) {
                            Text("\(item.placemark.thoroughfare ?? "") \(item.placemark.subThoroughfare ?? ""), \(item.placemark.locality ?? "") \(item.placemark.postalCode ?? "")")
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                            Divider()
                                .foregroundColor(.white)
                        }
                    }.frame(height: 30)
                        .padding(5)
                        .padding(.leading, 15)
                }
            }
        }.preferredColorScheme(.dark)
    }
}
// To make filterdItems identifiable
extension MKMapItem: Identifiable {
    public var id: String {
        return self.name ?? UUID().uuidString
    }
}
struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar().environmentObject(RideInformation())
    }
}
