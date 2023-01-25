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
                    Button{
                        rideInformation.searchBar.toggle()
                    } label: {
                        HStack{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.black)
                                .padding()
                                .padding(.trailing, 0)
                            CustomTextField(placeholder: Text("Where to?").foregroundColor(.black), text: $rideInformation.searchText)
                                .padding(.leading, 0)
                        }.frame(width: 350, height: 60)
                            .background(.white)
                            .cornerRadius(25)
                            .padding()
                    }.sheet(isPresented: $rideInformation.searchBar){
                        SearchBar()
                    }
                    HStack {
                        Image(systemName: "airplane.departure")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                        VStack {
                            HStack {
                                CustomTextField(placeholder: Text("Which flight you had?")
                                    .foregroundColor(.gray), text: $rideInformation.flightNumber)
                                .foregroundColor(.white)
                                Button(action: {
                                    rideInformation.flightNumber = ""
                                }, label: {
                                    if !rideInformation.flightNumber.isEmpty {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                                    }})
                            }
                        }.padding()
                    }.padding(.leading, 25)
                    Spacer(minLength: 10)
                    MapView()
                        .frame(width: 350, height: 200)
                        .cornerRadius(25)
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.black)
                        Text("Search")
                            .foregroundColor(.black)
                    }.frame(width: 350, height: 50)
                        .background(.white)
                        .cornerRadius(25)
                        .padding()
                }
            }
            .navigationTitle("Ride")
            .preferredColorScheme(.dark)
        }
    }
}

struct RideView_Previews: PreviewProvider {
    static var previews: some View {
        RideView().environmentObject(RideInformation())
    }
}
