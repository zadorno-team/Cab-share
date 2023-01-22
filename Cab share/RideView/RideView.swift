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
    @State private var flightNumber: String = ""
    @State private var wrongFlightNumber: String = ""
    @State private var selectedNumber = 1
    @State private var showPicker = false
    @State private var savedPlace = false
    @State private var alreadyMade = false
    let numbers = Array(1...10)
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack {
                        Text("Hello, Sasha! Nice to see you in the  International Airport of Naples!")
                            .padding(20)
                        VStack {
                            Image(systemName: "cloud.sun.fill")
                                .foregroundColor(.yellow)
                                .font(.system(size: 45))
                                .padding(.bottom, 30.0)
                                .opacity(0.7)
                        }
                    }.frame(width: 350)
                        .background(Color.blue)
                        .cornerRadius(25)
                        .padding(.top, 5)
                    //                    SearchBar()
                    //                        .frame(width: 350, height: 60)
                    //                        .background(.white)
                    //                        .cornerRadius(25)
                    //                        .padding(20)
                    //                        .foregroundColor(.black)
                    HStack {
                        Image(systemName: "airplane.departure")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                        VStack {
                            HStack {
                                CustomTextField(placeholder: Text("Which flight you had?")
                                    .foregroundColor(.gray), text: $flightNumber)
                                .foregroundColor(.white)
                                .onChange(of: flightNumber) { flightNumber in
                                    checkFlightNumber(userInput: flightNumber)
                                }
                            }
                            Button(action: {
                                self.rideVM.userFlightNumber = flightNumber
                            }, label: {
                                if !flightNumber.isEmpty {
                                    Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                                }
                            })
                        }
                    }.padding()
                }.padding(.leading, 25)
                Text(wrongFlightNumber)
                if let flightStatus = rideVM.flightStatus {
                    Text("Your flight details:")
                        .font(.headline)
                    Text("Departure airport: \(flightStatus.data[0].departure.airport.iata)")
                    Text("Departure time: \(flightStatus.data[0].departure.passengerLocalTime)")
                    Text("Arrival airport: \(flightStatus.data[0].arrival.airport.iata)")
                    Text("Departure time: \(flightStatus.data[0].arrival.date)")
                    Text("Arrival time: \(flightStatus.data[0].arrival.passengerLocalTime)")
                } else {
                    Text("Nothing show")
                }
                //                    HStack {
                //                        Image(systemName: "person.fill")
                //                            .foregroundColor(.gray)
                //                            .font(.system(size: 30))
                //                        VStack {
                //                            Button {
                //                                self.showPicker = true
                //                            } label: {
                //                                if showPicker {
                //                                    Picker("Select a number", selection: self.$selectedNumber) {
                //                                        ForEach(self.numbers, id: \.self) { number in
                //                                            Text("\(number)")
                //                                        }
                //                                    }
                //                                } else {
                //                                    Text("How many people with you?").padding(.trailing, 25)
                //                                }
                //                            }.frame(width: 260, height: 10)
                //                                .accentColor(.gray)
                //                        }.padding()
                //                    }
                //                    Button {
                //                        self.savedPlace.toggle()
                //                    } label: {
                //                        Image(systemName: "star.fill")
                //                            .foregroundColor(.gray)
                //                        Text("Choose a saved place")
                //                            .foregroundColor(.gray)
                //                        Spacer()
                //                    }
                //                    .padding([.top, .bottom])
                //                    .padding(.leading, 25)
                //                    .sheet(isPresented: $savedPlace) {
                //                    }
                //                    Button {
                //                        self.alreadyMade.toggle()
                //                    } label: {
                //                        Image(systemName: "figure.run")
                //                            .foregroundColor(.gray)
                //                        Text("Choose an already made journey")
                //                            .foregroundColor(.gray)
                //                        Spacer()
                //                    }.padding(.leading, 25)
                //                        .padding(.bottom)
                //                        .sheet(isPresented: $alreadyMade) {
                //                        }
                //                    Map(coordinateRegion: .constant(MKCoordinateRegion(
                //                        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
                //                        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))),
                //                        interactionModes: [])
                //                    .frame(width: 350, height: 200)
                //                    .cornerRadius(25)
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
                    .padding()
            }
        }
        .navigationTitle("Ride")
        .preferredColorScheme(.dark)
    }
    
    func checkFlightNumber(userInput value: String) {
        
        guard let regexExpression = try? NSRegularExpression(pattern: "\\b([A-Z]{2}|[A-Z]\\d)\\s?\\d{4}\\b") else {
            return
        }
        let range = NSRange(location: 0, length: value.utf16.count)
        
        let result = regexExpression.firstMatch(in: value, options: [], range: range)
        
        if result != nil {
            flightNumber = value
            wrongFlightNumber = ""
        } else {
            wrongFlightNumber = "Please enter valid flight number. Ex: F2 1122"
        }
        
//        if let firstCharacter = getCharacter(at: 0, from: value), firstCharacter.isLetter {
//            previousFlightNumber = value
//            wrongFlightNumber = ""
//            if let secondCharacter = getCharacter(at: 1, from: value), (secondCharacter.isLetter || secondCharacter.is) {
//                previousFlightNumber = value
//                wrongFlightNumber = ""
//            } else {
//                flightNumber = previousFlightNumber
//                wrongFlightNumber = "Only letters or numbers"
//            }
//        } else {
//            if value.isEmpty {
//                previousFlightNumber = ""
//            } else {
//                flightNumber = previousFlightNumber
//                wrongFlightNumber = "Only letters"
//            }
//        }
        
        
    }
    
    func getCharacter(at index: Int, from value: String) -> Character? {
        return value.count > index ? value[value.index(value.startIndex, offsetBy: 0)] : nil
    }
}

struct RideView_Previews: PreviewProvider {
    static var previews: some View {
        RideView(rideVM: RideViewModel())
    }
}
