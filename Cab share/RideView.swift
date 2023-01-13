//
//  RideView.swift
//  Cab share
//
//  Created by Marco Dell'Isola on 11/01/23.
//

import MapKit
import SwiftUI

struct RideView: View {
    @State var flightNumber: String = ""
    @State private var selectedNumber = 1
    @State private var showPicker = false
    @State private var savedPlace = false
    @State private var alreadyMade = false
    @State private var peopleNumber: String = "How many people with you?"
    let numbers = Array(1...10)
    var body: some View {
        NavigationView {
            ScrollView{
                VStack {
                    HStack{
                        Text("Hello, Sasha! Nice to see you in the  International Airport of Naples!")
//                            .foregroundColor(.white)
                            .padding(20)
                        VStack{
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
                        .padding(20)
                        .foregroundColor(.black)
                    
                    
                    HStack{
                        VStack{
                            Image(systemName: "airplane.departure")
                                .foregroundColor(.gray)
                                .font(.system(size: 30))
                        }
                        VStack{
                            HStack{
                                CustomTextField(placeholder: Text("Which flight you had?").foregroundColor(.gray), text: $flightNumber)
                                    .foregroundColor(.white)
                                Button(action: {
                                    self.flightNumber = ""
                                }, label: {
                                    if !flightNumber.isEmpty {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                                    }})
                            }
                        }.padding()
                    }.padding(.leading, 25)
                    
                    HStack{
                        VStack{
                            Image(systemName: "person.fill")
                                .foregroundColor(.gray)
                                .font(.system(size:30))
                        }
                        VStack{
                            Button {
                                self.showPicker = true
                                peopleNumber = ""
                            } label: {
                                if showPicker{
                                    Picker("Select a number", selection: self.$selectedNumber) {
                                        ForEach(self.numbers, id: \.self) { number in
                                            Text("\(number)")
                                        }
                                    }
                                }else {
                                    Text("How many people with you?").padding(.trailing, 25)
                                }
                            }.frame(width: 260,height: 10)
                                .accentColor(.gray)
                        }.padding()
                    }
                    
                    Button{
                        self.savedPlace.toggle()
                    } label: {
                        Image(systemName: "star.fill")
                            .foregroundColor(.gray)
                        Text("Choose a saved place")
                            .foregroundColor(.gray)
                        Spacer()
                    }
                    .padding([.top,.bottom])
                    .padding(.leading,25)
                    .sheet(isPresented: $savedPlace){
                        
                    }
                    
                    Button{
                        self.alreadyMade.toggle()
                    } label: {
                        Image(systemName: "figure.run")
                            .foregroundColor(.gray)
                        Text("Choose an already made journey")
                            .foregroundColor(.gray)
                        Spacer()
                    }.padding(.leading,25)
                        .padding(.bottom)
                        .sheet(isPresented: $alreadyMade){
                            
                        }
                    
                    Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))), interactionModes: [])
                        .frame(width: 350, height: 200)
                        .cornerRadius(25)
                    
                    Button{
                        
                    } label:{
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
        RideView()
    }
}
