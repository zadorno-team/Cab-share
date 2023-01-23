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
    //    @State private var flightNumber: String = ""
    //    @State private var wrongFlightNumber: String = ""
    //    @State private var flightDate = Date()
    @State private var selectedNumber = 1
    @State private var showPicker = false
    @State private var savedPlace = false
    @State private var alreadyMade = false
    @StateObject private var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    let numbers = Array(1...10)
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        if let location = locationManager.location {
                            if let weather = weather {
                                HStack {
                                    Text("Hello, Sasha! Nice to see you here \(locationManager.city)!")
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
                    SearchBar()
                        .frame(width: 350, height: 60)
                        .background(.white)
                        .cornerRadius(25)
                        .padding(5)
                        .foregroundColor(.black)
                    HStack {
                        Image(systemName: "airplane.departure")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                        CustomTextField(placeholder: Text("Enter your flight number")
                            .foregroundColor(.gray), text: $rideVM.userFlightNumber)
                        .foregroundColor(.white)
                        .limitInputLength(value: $rideVM.userFlightNumber, length: 7)
                        .onChange(of: rideVM.userFlightNumber) { flightNumber in
                            rideVM.checkFlightNumber(userInput: rideVM.userFlightNumber)
                        }
                        Button(action: {
                            rideVM.userFlightNumber = ""
                        }, label: {
                            if rideVM.userFlightNumber.isEmpty {
                                Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                            }
                        })
                    }.padding(.horizontal).padding(.top, 5)
                    Text(rideVM.wrongFlightNumber)
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                            .padding(.trailing, 9)
                        DatePicker("Departure date", selection: $rideVM.userDepartureDate, in: Date()..., displayedComponents: [.date])
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
                }
                HStack {
                    Image(systemName: "person.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 30))
                    Button {
                        self.showPicker = true
                    } label: {
                        if showPicker {
                            Picker("Select a number", selection: self.$selectedNumber) {
                                ForEach(self.numbers, id: \.self) { number in
                                    Text("\(number)")
                                }
                            }
                        } else {
                            Text("How many people with you?").padding(.trailing, 25)
                        }
                    }.frame(width: 260, height: 10)
                        .accentColor(.gray)
                    Spacer()
                }.padding(.leading, 20)
                Button {
                    self.savedPlace.toggle()
                } label: {
                    Image(systemName: "star.fill")
                        .foregroundColor(.gray)
                    Text("Choose a saved place")
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding([.top, .bottom])
                .padding(.leading, 25)
                .sheet(isPresented: $savedPlace) {
                }
                Button {
                    self.alreadyMade.toggle()
                } label: {
                    Image(systemName: "figure.run")
                        .foregroundColor(.gray)
                    Text("Choose an already made journey")
                        .foregroundColor(.gray)
                    Spacer()
                }.padding(.leading, 25)
                    .sheet(isPresented: $alreadyMade) {
                    }
                Button {
                    Task {
                        await rideVM.getFlightStatus()
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
                Map(coordinateRegion: .constant(MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                    span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))),
                    interactionModes: [])
                .frame(width: 350, height: 200)
                .cornerRadius(25)
            }
        }
        .navigationTitle("Ride")
        .preferredColorScheme(.dark)
    }
}

struct RideView_Previews: PreviewProvider {
    static var previews: some View {
        RideView(rideVM: RideViewModel())
    }
}
