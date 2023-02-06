//
//  RideView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 11/01/23.
//

import MapKit
import SwiftUI

struct RideView: View {
    @ObservedObject var rideVM: RideViewModel
    @EnvironmentObject var rideInformation: RideInformation
    @State private var flightNumber: String = ""
    @State private var flightDate = Date()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    let numbers = Array(1...10)
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        if let location = rideVM.locationManager.location {
                            if let weather = weather {
                                HStack {
                                    Text("Hello, Sasha! Nice to see you here \(rideVM.locationManager.city)!")
                                        .padding(20)
                                    Image(String(weather.weather[0].icon))
                                        .resizable()
                                        .frame(width: 90, height: 90)
                                        .foregroundColor(.yellow)
                                        .padding(.bottom, 30.0)
                                        .opacity(0.7)
                                }
                            } else {
                                LoadingView()
                                    .task {
                                        do {
                                            weather = try await
                                            weatherManager.getCurrentWeather(latitude: location.latitude,
                                                                             longitude: location.longitude)
                                        } catch {
                                            print("Error getting weather: \(error)")
                                        }
                                    }
                            }
                        } else {
                            Text("Hello, Sasha! Nice to see you here !")
                                .padding(20)
                        }
                    }.frame(width: 350)
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding(.top, 5)
                    Button {
                        rideInformation.searchBar.toggle()
                    } label: {
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding(.trailing, 0)
                                .padding(.leading, 15)
                            CustomTextField(placeholder: Text("Where to?").foregroundColor(.black), text: $rideInformation.searchText).foregroundColor(.black)
                                .padding(.leading, 0)
                                .truncationMode(.tail)
                        }.frame(width: 350, height: 50)
                            .background(.white)
                            .cornerRadius(25)
                            .padding(.vertical, 5)
                    }.sheet(isPresented: $rideInformation.searchBar) {
                        SearchBar()
                    }
                    HStack {
                        Image(systemName: "airplane.departure")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                        CustomTextField(placeholder: Text("Enter your flight number")
                            .foregroundColor(.gray), text: $flightNumber)
                        .foregroundColor(.white)
                        .limitInputLength(value: $flightNumber, length: 7)
                        .onChange(of: flightNumber) { flightNumber in
                            rideVM.checkFlightNumber(userInput: flightNumber)
                        }
                        Button(action: {
                            self.flightNumber = ""
                        }, label: {
                            if !flightNumber.isEmpty {
                                Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                            }
                        })
                    }.padding(.horizontal).padding(.top, 5)
                    Text(rideVM.error ?? "")
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                            .padding(.trailing, 9)
                        DatePicker("Departure date", selection: $flightDate, in: Date()..., displayedComponents: [.date])
                            .accentColor(.gray)
                            .opacity(0.6)
                    }.padding(.horizontal).padding(.bottom, 10)
                  
                    Spacer(minLength: 10)
                    MapView(latitude: $rideInformation.latitude, longitude: $rideInformation.longitude)
                        .frame(width: 350, height: 200)
                        .cornerRadius(25)
                    NavigationLink (destination: RideListView(rideVM: rideVM, flightNumber: flightNumber, flightDate: flightDate)) {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }.frame(width: 350, height: 50)
                        .background(.white)
                        .cornerRadius(25)
                        .padding(5)
                        .foregroundColor(.black)
                    if !$rideVM.previousApiRequests.isEmpty {
                        VStack {
                            Text("Your previous requests:")
                                .padding(.horizontal, 25)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.headline)
                            HistoryRowApiRequestView(historyRequests: $rideVM.previousApiRequests)
                        }
                    }
                }.navigationTitle("Ride")
            }
        }.preferredColorScheme(.dark)
    }
}

struct RideView_Previews: PreviewProvider {
    static var previews: some View {
        RideView(rideVM: RideViewModel()).environmentObject(RideInformation())
    }
}
