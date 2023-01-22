//
//  RideView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 11/01/23.
//

import MapKit
import SwiftUI

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int
    
    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}

struct RideView: View {
    @ObservedObject var rideVM: RideViewModel
    @State private var flightNumber: String = ""
    @State private var wrongFlightNumber: String = ""
    @State private var selectedNumber = 1
    @State private var showPicker = false
    @State private var savedPlace = false
    @State private var alreadyMade = false
    let numbers = Array(1...5)
    var dateFormatter: DateFormatter {
        let formater = DateFormatter()
        formater.dateStyle = .long
        return formater
    }
    @State private var flightDate = Date()
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
                                .foregroundColor(.gray), text: $flightNumber)
                            .foregroundColor(.white)
                            .limitInputLength(value: $flightNumber, length: 7)
                            .onChange(of: flightNumber) { flightNumber in
                                checkFlightNumber(userInput: flightNumber)
                            }
                            Button(action: {
                                self.rideVM.userFlightNumber = flightNumber
                            }, label: {
                                if !flightNumber.isEmpty {
                                    Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                                }
                            })
                    }.padding(.horizontal)
                    Text(wrongFlightNumber)
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.gray)
                            .font(.system(size: 30))
                            .padding(.trailing, 9)
                        DatePicker("Flight date", selection: $flightDate, in: Date()..., displayedComponents: [.date])
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
    func checkFlightNumber(userInput value: String) {
//        guard let regexExpression = try? NSRegularExpression(pattern: "\\b([A-Z]{2}|[A-Z]\\d)\\s?\\d{4}\\b") else {
//            return
//
        guard let regexExpression = try? NSRegularExpression(pattern: "(?<![\\dA-Z])(?!\\d{2})([A-Z\\d]{2})\\s?(\\d{2,4})(?!\\d)") else {
                return
        }
        let valueUpper = value.uppercased()
        let range = NSRange(location: 0, length: valueUpper.utf16.count)
        let result = regexExpression.firstMatch(in: valueUpper, options: [], range: range)
        if result != nil {
            flightNumber = valueUpper
            wrongFlightNumber = ""
        } else {
            if flightNumber.count > 5 {
                wrongFlightNumber = "Please enter valid flight number. Ex: F2 1122"
            } else {
                wrongFlightNumber = ""
            }
        }
    }
}

struct RideView_Previews: PreviewProvider {
    static var previews: some View {
        RideView(rideVM: RideViewModel())
    }
}
