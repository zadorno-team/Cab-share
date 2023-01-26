//
//  RideView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 11/01/23.
//

import MapKit
import SwiftUI

struct RideView: View {
    @EnvironmentObject var rideInformation: RideInformation
    @ObservedObject var rideVM: RideViewModel
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
                        }.frame(width: 350, height: 60)
                            .background(.white)
                            .cornerRadius(25)
                            .padding()
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
                            rideInformation.flightNumber = ""
                        }, label: {
                            if !rideInformation.flightNumber.isEmpty {
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
                    if let flightStatus = rideVM.flightStatus {
                        Text("Your flight details:")
                            .font(.headline)
                        Text("Departure airport: \(flightStatus.data[0].departure.airport.iata)")
                        Text("Departure time: \(flightStatus.data[0].departure.passengerLocalTime)")
                        Text("Arrival airport: \(flightStatus.data[0].arrival.airport.iata)")
                        Text("Departure time: \(flightStatus.data[0].arrival.date)")
                        Text("Arrival time: \(flightStatus.data[0].arrival.passengerLocalTime)")
                    }
                    Spacer(minLength: 10)
                    MapView(latitude: $rideInformation.latitude, longitude: $rideInformation.longitude)
                        .frame(width: 350, height: 200)
                        .cornerRadius(25)
                    Button {
                        Task {
                            await rideVM.getFlightStatus(userFlightNumber: flightNumber, userDepartureDate: flightDate)
                        }
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                        Text("Search")
                            .foregroundColor(.black)
                    }.frame(width: 350, height: 50)
                        .background(.white)
                        .cornerRadius(25)
                        .padding(5)
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
